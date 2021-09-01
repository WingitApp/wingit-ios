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
    @ServerTimestamp var createdTime: Timestamp?
    @ServerTimestamp var closedTime: Timestamp?
    var bumpedBy: [String]? // user ids
    var bumpCount: Int
    var comments: [String]?
    var createdBy: String
    var followers: [String]? // user ids
    var imageUrls: [String]
    var likeCount: Int
    var likedBy: [String: Bool]?
    var status: AskStatus
    var tags: [String]
    var title: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case bumpedBy
        case createdTime
        case closedTime
        case bumpCount
        case createdBy
        case followers
        case imageUrls
        case likeCount
        case likedBy
        case status
        case tags
        case title
        case text
    }
}

enum AskStatus: String, Codable {
    case open
    case closed
}
