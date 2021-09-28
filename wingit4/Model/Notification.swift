//
//  Activity.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Foundation


struct Notification: Encodable, Decodable, Equatable {
    
    var activityId: String
    var type: String
    var username: String
    var userId: String
    var userAvatar: String
    var postId: String
    var mediaUrl: String
    var comment: String
    var date: Double
    
    var typeDescription: String {
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
    
}
