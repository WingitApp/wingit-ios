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
    
    func sendReferral(askId: String,mediaUrl: String,  receiverId: String, senderId: String?) {
        guard let id = senderId else { return }
        let referral = Referral(id: nil, createdTime: nil, lastUpdatedTime: nil, askId: askId, children: nil, closedTime: nil, mediaUrl: mediaUrl, receiverId: receiverId, parentId: nil, senderId: id, status: .pending, text: nil)
        do {
            let _ = try Ref.FS_COLLECTION_REFERRALS.addDocument(from: referral)
        } catch {
            print(error)
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
