//
//  Ask.swift
//  wingit4
//
//  Created by Daniel Yee on 8/25/21.
//

import FirebaseFirestoreSwift
import Foundation

struct Ask: Identifiable, Codable {
    @DocumentID var id: String?
    var bumpCount: Int
    var comments: [Comment]?
    var closedAt: Double
    var createdAt: Double
    var createdBy: String
    var followers: [User]?
    var imageUrls: [String]
    var status: String
    var tags: [String]
    var title: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case bumpCount
        case comments
        case closedAt
        case createdAt
        case createdBy
        case followers
        case imageUrls
        case status
        case tags
        case title
        case text
    }
}
