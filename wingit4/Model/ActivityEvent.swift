//
//  ActivityEvent.swift
//  wingit4
//
//  Created by Daniel Yee on 8/30/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct ActivityEvent: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    var connectionId: String
    var mediaUrl: String
    var text: String
    var type: EventType
    var userId: String
}

enum EventType: String, Codable {
    case id
    case createdTime
    case comment
    case connectRequest
    case connectRequestAccepted
    case like
}
