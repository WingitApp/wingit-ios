//
//  Ask.swift
//  wingit4
//
//  Created by Daniel Yee on 8/25/21.
//

import Foundation

struct Ask: Identifiable, Codable {
    var id: String?
    var bumpCount: Int
    var comments: [Comment]?
    var closedAt: Double
    var createdAt: Double
    var createdBy: String
    var followers: [User]?
    var imageUrls: [String]
    var status: String
    var title: String
    var text: String
}
