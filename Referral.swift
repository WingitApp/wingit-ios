//
//  Referral.swift
//  wingit4
//
//  Created by Daniel Yee on 9/1/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct Referral: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    @ServerTimestamp var lastUpdatedTime: Timestamp? // first interaction with the referral
  
    var askId: String /// postId
    var children: [String]? // referral can be bumped and create more referrals
    var closedTime: Timestamp? // when the receiver is officially done helping and has moved it into a closed state
    var mediaUrl: String /// avatar pic? okie
    var receiverId: String
    var parentId: String? // referral that led to this referral
    var senderId: String ///Auth.auth().currentUser?.id
    var status: ReferralStatus
    var text: String?
  
    // client-side join
//    var ask: Post?
    var sender: User?
}

enum ReferralStatus: String, Codable {
    case accepted
    case bumped
    case closed
    case pending
}


