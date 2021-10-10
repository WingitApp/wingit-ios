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
    var createdAt: Timestamp?
    var uid: String?
    var bio: String?
    var canonicalEmail: String?
    var connections: [User]?
    var email: String
    var firstName: String?
    var keywords: [String]?
    var lastName: String?
    var notificationsLastSeenAt: Timestamp?
    var profileImageUrl: String?
    var tags: [String]? //attributes of the user
    var username: String?
    // social media
    var facebook: String?
    var twitter: String?
    var linkedin: String?
    var instagram: String?
    var reddit: String?
    var spotify: String?
    
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
        case facebook
        case twitter
        case linkedin
        case instagram
        case reddit
        case spotify
    }
  
    subscript(key: String) -> String {
          get {
              switch key {
                  case "facebook": return self.facebook ?? ""
                  case "twitter": return self.twitter ?? ""
                  case "linkedin": return self.linkedin ?? ""
                  case "instagram": return self.instagram ?? ""
                  case "reddit": return self.reddit ?? ""
                  case "spotify": return self.spotify ?? ""
                  default: fatalError("Invalid key")
              }
          }
          set {
              switch key {
                  case "facebook": self.facebook = newValue
                  case "twitter": self.twitter = newValue
                  case "linkedin": self.linkedin = newValue
                  case "instagram": self.instagram = newValue
                  case "reddit": self.reddit = newValue
                  case "spotify": self.spotify = newValue
                  default: fatalError("Invalid key")

              }
          }
      }
}
