//
//  Comment.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Comment: Codable, Identifiable, Equatable {
    var id = UUID()
    var comment: String?
    var avatarUrl: String?
    var inviterAvatarUrl: String?
    var inviterDisplayName: String?
    var inviterId: String?
    var ownerId: String?
    var postId: String?
    var username: String?
    var date: Double?
    var type: CommentType?
}

enum CommentType: String, Codable {
    case askPost
    case invitedReferral
}
