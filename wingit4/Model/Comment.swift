//
//  Comment.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//


import Foundation


struct Comment: Encodable, Decodable, Identifiable, Equatable {
    var id = UUID()
    var comment: String
    var avatarUrl: String
    var inviterAvatarUrl: String?
    var inviterDisplayName: String?
    var inviterId: String?
    var ownerId: String
    var postId: String
    var username: String
    var date: Double
    var type: CommentType?
}

enum CommentType: String, Codable {
    case askPost
    case invitedReferral
}

