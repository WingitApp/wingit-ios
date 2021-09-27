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
    
    func sendReferral(askId: String, receiverId: String?, senderId: String?) {
        guard let id = senderId, let receiverId = receiverId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil, updatedAt: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
            let activityId = Ref.FS_COLLECTION_ACTIVITY.document(receiverId).collection("feedItems").document().documentID
             let activityObject = Activity(activityId: activityId, type: "referred", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: askId, mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
            guard let activityDict = try? activityObject.toDictionary() else { return }

            Ref.FS_COLLECTION_ACTIVITY.document(receiverId).collection("feedItems").document(activityId).setData(activityDict)
        } catch {
            print(error)
        }
    }
    
    func rewingReferral(askId: String, receiverId: String?, parentId: String?, senderId: String?) {
        guard let id = senderId, let receiverId = receiverId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: parentId, senderId: id, status: .pending, text: nil, updatedAt: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
            let activityId = Ref.FS_COLLECTION_ACTIVITY.document(receiverId).collection("feedItems").document().documentID
             let activityObject = Activity(activityId: activityId, type: "referred", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: askId, mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
            guard let activityDict = try? activityObject.toDictionary() else { return }

            Ref.FS_COLLECTION_ACTIVITY.document(receiverId).collection("feedItems").document(activityId).setData(activityDict)
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
        if error != nil { return print(error) }
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
                        recipientIds.append(referral.receiverId)
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
          .whereField("receiverId", isEqualTo: userId)
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
                            print("load user error")
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
                          print("load user error")
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
                            print("load user error")
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
          .whereField("receiverId", isEqualTo: userId)
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
                            print("load user error")
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
                          print("load user error")
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
                            print("load user error")
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
          .whereField("receiverId", isEqualTo: userId)
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
                            print("load user error")
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
                          print("load user error")
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
                            print("load user error")
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
          .whereField("receiverId", isEqualTo: userId)
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
                            print("load user error")
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
                          print("load user error")
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
                            print("load user error")
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

