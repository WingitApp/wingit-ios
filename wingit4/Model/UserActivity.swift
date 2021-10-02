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
    var activityType: ActivityType?
    var commentId: String?
    var correspondingUserDisplayName: String?
    var correspondingUserId: String?
    var currentUserAvatarUrl: URL?
    var currentUserDisplayName: String? // display name of the currentUser performing the activity
    var currentUserId: String? // id of the currentUser performing the activity
    var mediaUrl: String?
    var postOwnerId: String? // id of the user who owns the post IF this activity relates to a post
    var postId: String? // id of the post IF this activity relates to a post
    var postTitle: String?
    var postType: PostType?
    var recipientIds: [String]?
    var referralId: String?
    var text: String? // text found in the comment, message, referral, post, etc.
    
    enum ActivityType: String, Codable {
        case acceptConnectRequest
        case declineConnectRequest
        case declineReferral
        case followPost
        case postAsk
        case postComment
        case reactToComment
        case referConnection
        case searchForUser
        case sendConnectRequest
        case sendMessage
        case viewConnections
        case viewUserProfile
        case wingAsk
    }
}
