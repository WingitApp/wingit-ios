//
//  ReferralsApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/1/21.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

class ReferralsApi {
    
    func sendReferral(askId: String, recipientId: String?, senderId: String?) {
        guard let id = senderId, let recipientId = recipientId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, recipientId: recipientId, parentId: nil, senderId: id, status: .pending, text: nil, updatedAt: nil)
        do {
            let activityId = Ref.FS_COLLECTION_ACTIVITY.document(recipientId).collection("feedItems").document().documentID
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
            // TODO: create referConnection UserActivity with referralId
            let notification = Notification(activityId: activityId, comment: "", date: Date().timeIntervalSince1970, mediaUrl: "", postId: askId, type: "referred", userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, userId: Auth.auth().currentUser!.uid, username: Auth.auth().currentUser!.displayName!)
            try Ref.FS_COLLECTION_ACTIVITY.document(recipientId).collection("feedItems").document(activityId).setData(from: notification)
        } catch {
            print(error)
        }
    }
    
    func rewingReferral(askId: String, recipientId: String?, parentId: String?, senderId: String?) {
        guard let id = senderId, let recipientId = recipientId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, recipientId: recipientId, parentId: parentId, senderId: id, status: .pending, text: nil, updatedAt: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
            let activityId = Ref.FS_COLLECTION_ACTIVITY.document(recipientId).collection("feedItems").document().documentID
             // TODO: add rewing UserActivity with referralId and parentId
            let notification = Notification(activityId: activityId, comment: "", date: Date().timeIntervalSince1970, mediaUrl: "", postId: askId, type: "referred", userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, userId: Auth.auth().currentUser!.uid, username: Auth.auth().currentUser!.displayName!)
            try Ref.FS_COLLECTION_ACTIVITY.document(recipientId).collection("feedItems").document(activityId).setData(from: notification)
        } catch {
            print(error)
        }
    }
    
    func updateStatus(referralId: String, newStatus: ReferralStatus) {
      Ref.FS_COLLECTION_REFERRALS.document(referralId).updateData(["status": newStatus.rawValue, "updatedAt": FieldValue.serverTimestamp()])
    }
  
    /**Used to get list of users who have winged (no listener attached)*/
    func getWingersByPostId(askId: String, onSuccess: @escaping(_ wingers: [User]) -> Void) {
      Ref.FS_COLLECTION_ALL_POSTS.document(askId).collection("wingers").getDocuments { (snapshot, error) in
          if error != nil { return print(error ?? "") }
        guard let snap = snapshot else { return }
        
        let wingers = snap.documents.compactMap {
          return try? $0.data(as: User.self)
        }
        onSuccess(wingers)
      }
    }
    
    func getReferralsByAskId(askId: String, onSuccess: @escaping(_ recipientIds: [String]) -> Void) {
        
        Ref.FS_COLLECTION_REFERRALS.whereField("askId", isEqualTo: askId)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error)
                } else if let snapshot = snapshot {
                    let referrals = snapshot.documents.compactMap { (document) -> Referral? in
                        return try? document.data(as: Referral.self)
                    }
                    
                    var recipientIds: [String] = []

                    for referral in referrals {
                        recipientIds.append(referral.recipientId)
                    }
                    
                    onSuccess(recipientIds)
                }
            }
    }

    func getPendingReferrals(
      onEmpty: @escaping () -> Void,
      onSuccess: @escaping(_ referrals: [Referral]) -> Void,
      newReferral: @escaping(Referral) -> Void,
      modifiedReferral: @escaping(Referral) -> Void,
      deleteReferral: @escaping(Referral) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let listenerFirestore = Ref.FS_COLLECTION_REFERRALS
          .whereField("recipientId", isEqualTo: userId)
          .whereField("status", isEqualTo: "pending")
          .order(by: "createdAt", descending: true)
          .addSnapshotListener { (snapshot, error) in
            guard let snap = snapshot else { return }
            if let error = error { return print(error) }
            
            if snap.documentChanges.count == 0 {
              return onEmpty()
            }
            
            snap.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                  let dispatchGroup = DispatchGroup()
                  
                  let referrals: [Referral] = snap.documents.compactMap {
                      return try? $0.data(as: Referral.self)
                  }
                  
                  var result = [Referral]()
                  for var referral in referrals {
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            result.append(referral)
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            result.append(referral)
                            dispatchGroup.leave()
                          }
                      }
                }
                    dispatchGroup.notify(queue: .main) {
                        onSuccess(result)
                    }
                case .modified:
                  guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    Api.Post.loadPost(postId: referral.askId) { (post) in
                        referral.ask = post
                        Api.User.loadUser(userId: referral.senderId) { (user) in
                          referral.sender = user
                          dispatchGroup.leave()
                        } onError: {
                          referral.sender = DELETED_USER
                          dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        modifiedReferral(referral)
                    }
                case .removed:
                    guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                      let dispatchGroup = DispatchGroup()
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            dispatchGroup.leave()
                          }
                      }
                      dispatchGroup.notify(queue: .main) {
                          deleteReferral(referral)
                      }
                }
            }
        }
        
        listener(listenerFirestore)
    }
    
    func getAcceptedReferrals(
      onEmpty: @escaping() -> Void,
      onSuccess: @escaping(_ referrals: [Referral]) -> Void,
      newReferral: @escaping(Referral) -> Void,
      modifiedReferral: @escaping(Referral) -> Void,
      deleteReferral: @escaping(Referral) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let listenerFirestore = Ref.FS_COLLECTION_REFERRALS
          .whereField("recipientId", isEqualTo: userId)
          .whereField("status", isEqualTo: ReferralStatus.accepted.rawValue)
          .order(by: "updatedAt", descending: true)
          .addSnapshotListener { (snapshot, error) in
            guard let snap = snapshot else { return }
            if let error = error { return print(error) }
            
            if snap.documentChanges.count == 0 {
              return onEmpty()
            }
            
            snap.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                  let dispatchGroup = DispatchGroup()
                  
                  let referrals: [Referral] = snap.documents.compactMap {
                      return try? $0.data(as: Referral.self)
                  }
                  
                  var result = [Referral]()
                  for var referral in referrals {
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            result.append(referral)
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            result.append(referral)
                            dispatchGroup.leave()
                          }
                      }
                }
                    dispatchGroup.notify(queue: .main) {
                        onSuccess(result)
                    }
                case .modified:
                  guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    Api.Post.loadPost(postId: referral.askId) { (post) in
                      referral.ask = post
                      Api.User.loadUser(userId: referral.senderId) { (user) in
                        referral.sender = user
                        dispatchGroup.leave()
                      } onError: {
                        referral.sender = DELETED_USER
                        dispatchGroup.leave()
                      }
                    }
                    dispatchGroup.notify(queue: .main) {
                        modifiedReferral(referral)
                    }
                case .removed:
                    guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                      let dispatchGroup = DispatchGroup()
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                        referral.ask = post
                        Api.User.loadUser(userId: referral.senderId) { (user) in
                          referral.sender = user
                          dispatchGroup.leave()
                        } onError: {
                          referral.sender = DELETED_USER
                          dispatchGroup.leave()
                        }
                      }
                      dispatchGroup.notify(queue: .main) {
                        deleteReferral(referral)
                      }
                }
            }
        }
        
        listener(listenerFirestore)
    }
    
    func getWingedReferrals(
      onEmpty: @escaping() -> Void,
      onSuccess: @escaping(_ referrals: [Referral]) -> Void,
      newReferral: @escaping(Referral) -> Void,
      modifiedReferral: @escaping(Referral) -> Void,
      deleteReferral: @escaping(Referral) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let listenerFirestore = Ref.FS_COLLECTION_REFERRALS
          .whereField("recipientId", isEqualTo: userId)
          .whereField("status", isEqualTo: ReferralStatus.winged.rawValue)
          .order(by: "updatedAt", descending: true)
          .addSnapshotListener { (snapshot, error) in
            guard let snap = snapshot else { return }
            if let error = error { return print(error) }
            
            if snap.documentChanges.count == 0 {
              return onEmpty()
            }
            
            snap.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                  let dispatchGroup = DispatchGroup()
                  
                  let referrals: [Referral] = snap.documents.compactMap {
                      return try? $0.data(as: Referral.self)
                  }
                  
                  var result = [Referral]()
                  for var referral in referrals {
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            result.append(referral)
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            result.append(referral)
                            dispatchGroup.leave()
                          }
                      }
                }
                    dispatchGroup.notify(queue: .main) {
                        onSuccess(result)
                    }
                case .modified:
                  guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    Api.Post.loadPost(postId: referral.askId) { (post) in
                      referral.ask = post
                      Api.User.loadUser(userId: referral.senderId) { (user) in
                        referral.sender = user
                        dispatchGroup.leave()
                      } onError: {
                        referral.sender = DELETED_USER
                        dispatchGroup.leave()
                      }
                    }
                    dispatchGroup.notify(queue: .main) {
                        modifiedReferral(referral)
                    }
                case .removed:
                    guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                      let dispatchGroup = DispatchGroup()
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            dispatchGroup.leave()
                          }
                      }
                      dispatchGroup.notify(queue: .main) {
                          deleteReferral(referral)
                      }
                }
            }
        }
        
        listener(listenerFirestore)
    }
    
    func getClosedReferrals(
      onEmpty: @escaping() -> Void,
      onSuccess: @escaping(_ referrals: [Referral]) -> Void,
      newReferral: @escaping(Referral) -> Void,
      modifiedReferral: @escaping(Referral) -> Void,
      deleteReferral: @escaping(Referral) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let listenerFirestore = Ref.FS_COLLECTION_REFERRALS
          .whereField("recipientId", isEqualTo: userId)
          .whereField("status", isEqualTo: ReferralStatus.closed.rawValue)
          .order(by: "updatedAt", descending: true)
          .addSnapshotListener { (snapshot, error) in
            guard let snap = snapshot else { return }
            if let error = error { return print(error) }
            
            if snap.documentChanges.count == 0 {
              return onEmpty()
            }
            
            snap.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                  let dispatchGroup = DispatchGroup()
                  
                  let referrals: [Referral] = snap.documents.compactMap {
                      return try? $0.data(as: Referral.self)
                  }
                  
                  var result = [Referral]()
                  for var referral in referrals {
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                          referral.ask = post
                          Api.User.loadUser(userId: referral.senderId) { (user) in
                            referral.sender = user
                            result.append(referral)
                            dispatchGroup.leave()
                          } onError: {
                            referral.sender = DELETED_USER
                            result.append(referral)
                            dispatchGroup.leave()
                          }
                      }
                }
                    dispatchGroup.notify(queue: .main) {
                        onSuccess(result)
                    }
                case .modified:
                  guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    Api.Post.loadPost(postId: referral.askId) { (post) in
                        referral.ask = post
                        Api.User.loadUser(userId: referral.senderId) { (user) in
                          referral.sender = user
                          dispatchGroup.leave()
                        } onError: {
                          referral.sender = DELETED_USER
                          dispatchGroup.leave()
                        }
                    }
                    dispatchGroup.notify(queue: .main) {
                        modifiedReferral(referral)
                    }
                case .removed:
                    guard var referral = try? documentChange.document.data(as: Referral.self) else { return }
                      let dispatchGroup = DispatchGroup()
                      dispatchGroup.enter()
                      Api.Post.loadPost(postId: referral.askId) { (post) in
                        referral.ask = post
                        Api.User.loadUser(userId: referral.senderId) { (user) in
                          referral.sender = user
                          dispatchGroup.leave()
                        } onError: {
                          referral.sender = DELETED_USER
                          dispatchGroup.leave()
                        }
                      }
                      dispatchGroup.notify(queue: .main) {
                        deleteReferral(referral)
                      }
                }
            }
        }
        
        listener(listenerFirestore)
    }
}

