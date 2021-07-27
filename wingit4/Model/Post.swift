//
//  Post.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation


struct Post: Encodable, Decodable {
    var caption: String
    var likes: [String: Bool]
    var location: String
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
}

//struct DonePost: Encodable, Decodable {
//    var caption: String
//    var doneMediaUrl: String
//    var ownerId: String
//    var postId: String
//    var username: String
//    var avatar: String
//}
