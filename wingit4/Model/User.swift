//
//  User.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Equatable, Hashable {

    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    var uid: String?
    var bio: String?
    var canonicalEmail: String?
    var connections: [User]?
    var email: String
    var firstName: String?
    var keywords: [String]?
    var lastName: String?
    var profileImageUrl: String?
    var tags: [String]?
    var username: String?
    var profileLinks: ProfileLinks?

    var displayName: String? {
      return "\(self.firstName ?? "") \(self.lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }

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
        case profileLinks
    }
}

 
struct ProfileLinks: Codable, Equatable, Hashable {
      var airbnb: URL?
      var spotify: URL?
      var twitter: URL?
      var instagram: URL?
      var vsco: URL?
      var googleDrive: URL?
    //  var more: [URL]?
}
