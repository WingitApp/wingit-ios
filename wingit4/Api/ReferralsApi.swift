//
//  ReferralsApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/1/21.
//


import Foundation
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class ReferralsApi {
    
    func sendReferral(askId: String, receiverId: String, senderId: String?) {
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func bumpReferral(askId: String, receiverId: String, parentId: String, senderId: String?){
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: parentId, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func updateStatus(referralId: String, newStatus: ReferralStatus) {
        Ref.FS_COLLECTION_REFERRALS.document(referralId).updateData(["status": newStatus.rawValue])
    }
    
    func addChildrenId(referralId: String, childrenId: String){
        Ref.FS_COLLECTION_REFERRALS.document(referralId).updateData(["children": childrenId])
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
<<<<<<< HEAD

    func getPendingReferrals(onSuccess: @escaping(_ referrals: [Referral]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Ref.FS_COLLECTION_REFERRALS.whereField("receiverId", isEqualTo: userId).whereField("status", isEqualTo: "pending").getDocuments { (snapshot, error) in
        // catch errors
        guard let snap = snapshot else { return }
        if let error = error { return print(error) }
        
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
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            onSuccess(result)
        }
        
      }
  //}
    }
}
=======
  
//  , onSuccess: @escaping(_ referrals: [Referral]) -> Void
  
  func getAllReferrals(onSuccess: @escaping(_ referrals: [Referral]) -> Void) {
    /**
          1. get all user's referrals
          2. get referral's ask (or post)
          3.  get user object by senderId
     */
    
    
    Api.Connections.getConnections(userId: Auth.auth().currentUser!.uid ) { (users) in
      let allConnections = users.reduce([String: User]()) { (dict, user) -> [String: User] in
        var dict = dict
        dict[user.id!] = user
        return dict
      }
            
      Ref.FS_COLLECTION_REFERRALS
        .whereField("receiverId", isEqualTo: Auth.auth().currentUser!.uid)
        .getDocuments { (snapshot, error) in
        if let error = error {
            return print(error)
        }
        
        if let snapshot = snapshot {
            let referrals = snapshot.documents.compactMap { (document) -> Referral? in
              let result = Result { try document.data(as: Referral.self) }
                switch result {
                  case .success(let referral):
                    if var referral = referral {
                      referral.sender = allConnections[referral.senderId]
                      guard let decodedReferral = try? Referral.init(fromDictionary: referral) else { return nil }
                      return decodedReferral
                    }
                    else {
                      print("Document doesn't exist.")
                    }
                  case .failure(let error):
                    // A User could not be initialized from the DocumentSnapshot.
                      printDecodingError(error: error)
                  }
            }
          
          
          onSuccess(referrals)
          
        }
        
      }
      
      
    }
    
    
  }
    
    
//    func referralExists(askId: String, receiverId: String){
//        
//    }
}


//struct Referral: Codable, Identifiable {
//    @DocumentID var id: String?
//    @ServerTimestamp var createdTime: Timestamp?
//    @ServerTimestamp var firstInteractionTime: Timestamp? // first interaction with the referral
//    @ServerTimestamp var closedTime: Timestamp? // when the receiver is officially done helping and has moved it into a closed state
//    var askId: String /// postId
//    var children: [String]? // referral can be bumped and create more referrals
//    var mediaUrl: String /// avatar pic? okie
//    var receiverId: String
//    var parentId: String? // referral that led to this referral
//    var senderId: String ///Auth.auth().currentUser?.id
//    var status: ReferralStatus
//    var text: String
//}
//
//enum ReferralStatus: String, Codable {
//    case accepted
//    case bumped
//    case closed
//    case pending
//}
>>>>>>> 1190002 (init fetch referrals function)
