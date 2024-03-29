//
//  Ask.swift
//  wingit4
//
//  Created by Daniel Yee on 8/25/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct Ask: Identifiable, Codable {
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    var bumpedBy: [String]? // user ids
    var bumpCount: Int
    var closedAt: Timestamp?
    var comments: [String]?
    var createdBy: String // user id
    var followers: [String]? // user ids
    var imageUrls: [String]?
    var likeCount: Int
    var likedBy: [String: Bool]?
    var status: AskStatus
    var tags: [String]
    var text: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case bumpCount
        case bumpedBy
        case createdAt
        case closedAt
        case createdBy
        case followers
        case imageUrls
        case likeCount
        case likedBy
        case status
        case tags
        case text
        case title
    }
}

enum AskStatus: String, Codable {
    case open
    case closed
}
