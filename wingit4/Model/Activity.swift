//
//  Activity.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Foundation


struct Activity: Encodable, Decodable {
    
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
//        case "bumped":
//            ouput = ""
        case "follow":
            output = "is following you"
        case "like":
            output = "liked your post"
        case "likeAsk":
            output = "liked your post"
        case "connectRequest":
            output = "wants to connect"
        case "connectRequestAccepted":
            output = "accepted your connect request"
        default:
            output = ""
        }
        
        return output
    }
    
}

