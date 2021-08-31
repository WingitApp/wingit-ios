//
//  User.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var uid: String
    var bio: String
    var canonicalEmail: String?
    var connections: [User]?
    var createdAt: Double?
    var email: String
    var firstName: String?
    var keywords: [String]
    var lastName: String?
    var profileImageUrl: String
    var tags: [String]?
    var username: String

    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case bio
        case canonicalEmail
        case email
        case firstName
        case keywords
        case lastName
        case profileImageUrl
        case tags
        case username
    }
}
