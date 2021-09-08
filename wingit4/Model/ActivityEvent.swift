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
    @ServerTimestamp var createdAt: Timestamp?
    var connectionId: String? // id of the user who performed the event
    var connectionName: String?
    var mediaUrl: String?
    var text: String?
    
    var type: EventType
    var userId: String?
    
    var notificationMessage: String {
        var output = ""
        switch type {
            case .comment:
                output = "commented: \(text ?? "")..."
            case .connectRequest:
                output = "wants to connect."
            case .connectRequestAccepted:
                output = "accepted your connect request."
            case .likeAsk:
                output = "liked your post."
            default:
                output = ""
        }
        return output
    }
}

enum EventType: String, Codable {
    case id
    case comment
    case connectRequest
    case connectRequestAccepted
    case likeAsk
}
