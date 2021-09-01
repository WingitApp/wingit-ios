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
    @ServerTimestamp var closedTime: Timestamp?
    var askId: String
    var mediaUrl: String
    var receiverId: String
    var senderId: String
    var status: ReferralStatus
    var text: String
}

enum ReferralStatus: String, Codable {
    case accepted
    case ignored
    case pending
}
