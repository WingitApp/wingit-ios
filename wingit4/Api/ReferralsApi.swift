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
        let referral = Referral(id: nil, createdTime: nil, lastUpdatedTime: nil, askId: askId, children: nil, closedTime: nil, mediaUrl: "", receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
        }
    }
    
    func statusToBumped(askId: String, receiverId: String){

        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(postId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "bumped"])
                }
            }
        }
    }
    
    func acceptReferral(askId: String, receiverId: String) {
        
        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(postId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "accepted"])
                }
            }
        }
    }
    
    func ignoreReferral(askId: String, receiverId: String) {
        
        Ref.FS_COLLECTION_REFERRALS_FOR_ASK(postId: askId)?.whereField("receiverId", isEqualTo: receiverId).getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let doc = snapshot?.documents {
               
                if let data = doc.first, data.exists {
                    data.reference.updateData(["status": "closed"])
                }
            }
        }
    }
    
    
    /*
     1. If referral status is opened show on the current user's referral notification.
     2. So the function has to be get referrals in which the status is not closed.
     */
    
    func getOpenReferrals(askId: String, receiverId: String, onSuccess: @escaping(_ referrals: [Referral]) -> Void) {

        Ref.FS_COLLECTION_OPEN_REFERRALS_FOR_USER(userId: receiverId)?.whereField("askId", isEqualTo: askId).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                return
            }
            var referrals = [Referral]()
            for referral in snap.documents {
                let dict = referral.data()
                guard let decodedReferral = try? Referral.init(fromDictionary: dict) else {return}
                referrals.append(decodedReferral)
            }
            onSuccess(referrals)
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
