//
//  Post.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    var caption: String
    var likes: [String: Bool]
    var location: String
    var ownerId: String
    var postId: String
    var status: PostStatus?
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
    var title: String?
}

enum PostStatus: String, Codable {
    case open
    case closed
}

struct DonePost: Encodable, Decodable {
    var caption: String
    var doneMediaUrl: String
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var donedate: Double
    var askcaption: String
    var mediaUrl: String
    var asklocation: String
    var askdate: Double
}

