//
//  ActivityEvent.swift
//  wingit4
//
//  Created by Daniel Yee on 8/30/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct UserActivity: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    var commentId: String?
    var commentOwnerId: String? // id of the user who owns the comment
    var connectionId: String? // id of the user related to this connect request or connection activity
    var currentUserDisplayName: String? // display name of the currentUser performing the activity
    var currentUserId: String? // id of the currentUser performing the activity
    var mediaUrl: String?
    var otherUsersDisplayName: String? // displayName of the user whom the currentUser is interacting with
    var postOwnerId: String? // id of the user who owns the post related to this activity
    var postId: String?
    var recipientId: String?
    var senderId: String? // id of the user winging the ask or sending the message
    var text: String? // text found in the comment, message, referral, post, etc.
    var type: ActivityType
    
    enum ActivityType: String, Codable {
        case acceptConnectRequest
        case declineConnectRequest
        case declineReferral
        case followPost
        case reactToComment
        case referConnection
        case postAsk
        case postComment
        case searchForUser
        case sendConnectRequest
        case sendMessage
        case viewConnections
        case viewUserProfile
        case wingAsk
    }
}
