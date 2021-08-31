//
//  ActivityEvent.swift
//  wingit4
//
//  Created by Daniel Yee on 8/30/21.
//

import FirebaseFirestoreSwift
import Foundation

struct ActivityEvent: Codable, Identifiable {
    @DocumentID var id: String?
    var connectionId: String
    var createdAt: Double
    var mediaUrl: String
    var text: String
    var type: EventType
    var userId: String
}

enum EventType: String, Codable {
    case comment
    case connectRequest
    case connectRequestAccepted
    case like
}
