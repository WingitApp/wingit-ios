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
}
