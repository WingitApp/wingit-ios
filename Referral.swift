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
    @ServerTimestamp var createdAt: Timestamp?
  
    var askId: String //postId
    var children: [String]? // referral can be bumped and create more referrals
    var closedAt: Timestamp? // when the receiver is officially done helping and has moved it into a closed state
    var mediaUrl: String? // avatar pic? okie
    var receiverId: String
    var parentId: String? // referral that led to this referral
    var senderId: String // Auth.auth().currentUser?.uid
    var status: ReferralStatus
    var text: String?
    var updatedAt: Timestamp?
  
    // client-side join
    var ask: Post?
    var sender: User?

    enum CodingKeys: String, CodingKey {
        case id
        case askId
        case closedAt
        case mediaUrl
        case receiverId
        case parentId
        case senderId
        case status
        case text
        case updatedAt
    }
}

enum ReferralStatus: String, Codable {
    case accepted
    case bumped
    case closed
    case pending
}



