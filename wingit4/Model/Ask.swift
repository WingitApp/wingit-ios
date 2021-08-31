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
    var bumpedBy: [User]?
    var bumpCount: Int
    var comments: [Comment]?
    var createdBy: String
    var followers: [User]?
    var imageUrls: [String]
    var latitude: Double?
    var longitude: Double?
    var status: String
    var tags: [String]
    var title: String
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdTime
        case closedTime
        case bumpCount
        case comments
        case createdBy
        case followers
        case imageUrls
        case status
        case tags
        case title
        case text
    }
}
