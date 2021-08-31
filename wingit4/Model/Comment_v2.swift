//
//  Comment.swift
//  wingit4
//
//  Created by Daniel Yee on 8/31/21.
//

import FirebaseFirestoreSwift
import Foundation

struct Comment_v2: Codable, Identifiable {
    @DocumentID var id: String? // = askId or recId
    var askId: String?
    var children: [Comment]?
    var createdAt: Double?
    var createdByUser: User?
    var createdBy: String?
    var likedBy: [User]?
    var likeCount: Int?
    var mediaUrls: [String]?
    var parentId: String?
    var recId: String?
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case askId
        case createdAt
        case createdBy
        case likeCount
        case mediaUrls
        case parentId
        case recId
        case text
    }
}

