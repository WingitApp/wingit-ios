//
//  Activity.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Foundation
import SwiftUI

struct Notification: Codable, Equatable {
    var post: Post?
    
    // legacy fields
    var activityId: String
    var comment: String
    var date: Double
    var mediaUrl: String
    var postId: String
    var type: String
    var userAvatar: String
    var userId: String
    var username: String
    
    var typeDescription: String? {
        var output = ""
        switch type {
        case "comment":
            output = "replied: \(comment)"
        case "referred":
            output = "has referred you to help."
        case "follow":
            output = "is following you."
        case "like":
            output = "liked your post!"
        case "likeAsk":
            output = "liked your post!"
        case "connectRequest":
            output = "wants to connect with you!"
        case "connectRequestAccepted":
            output = "accepted your connect request!"
        default:
            output = ""
        }

        return output
    }
    
    enum CodingKeys: String, CodingKey {
        case activityId
        case comment
        case date
        case mediaUrl
        case postId
        case type
        case userAvatar
        case userId
        case username
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        activityId = try container.decode(String.self, forKey: .activityId)
//        comment = try container.decode(String.self, forKey: .comment)
//        date = try container.decode(Double.self, forKey: .date)
//        mediaUrl = try container.decode(String.self, forKey: .mediaUrl)
//        postId = try container.decode(String.self, forKey: .postId)
//        type = try container.decode(String.self, forKey: .type)
//        userAvatar = try container.decode(String.self, forKey: .userAvatar)
//        userId = try container.decode(String.self, forKey: .userId)
//        username = try container.decode(String.self, forKey: .username)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(activityId, forKey: .activityId)
//        try container.encode(comment, forKey: .comment)
//        try container.encode(date, forKey: .date)
//        try container.encode(mediaUrl, forKey: .mediaUrl)
//        try container.encode(postId, forKey: .postId)
//        try container.encode(type, forKey: .type)
//        try container.encode(userAvatar, forKey: .userAvatar)
//        try container.encode(userId, forKey: .userId)
//        try container.encode(username, forKey: .username)
//    }
}
