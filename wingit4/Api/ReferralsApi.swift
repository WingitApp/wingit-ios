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
    
<<<<<<< HEAD
    func sendReferral(askId: String, receiverId: String, senderId: String?) {
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdAt: nil, askId: askId, children: nil, closedAt: nil, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
=======
    func sendReferral(askId: String,mediaUrl: String,  receiverId: String, senderId: String?) {
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdTime: nil, lastUpdatedTime: nil, askId: askId, children: nil, closedTime: nil, mediaUrl: mediaUrl, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
>>>>>>> 77ddfdf (Referrals Api)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
<<<<<<< HEAD
    
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
>>>>>>> 77ddfdf (Referrals Api)
