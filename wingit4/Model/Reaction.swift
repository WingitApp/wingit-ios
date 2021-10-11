//
//  Reaction.swift
//  wingit4
//
//  Created by Joshua Lee on 9/29/21.
//

import SwiftUI
import Firebase

struct Reaction: Encodable, Decodable, Identifiable, Hashable, Equatable {
  var id = UUID()
  var emojiCode:  Int
  var commentId: String?
  var reactorId: String
  var avatarUrl: String
  var username: String
  var createdAt: Double?
  var updatedAt: Double?
  var score: ReactionScore?
  var isOwn: Bool? {
    // returns if reaction is own
    return reactorId == Auth.auth().currentUser?.uid
  }

}

enum ReactionScore: Int, Codable {
    case negative = -1
    case neutral = 0
    case positive = 1
}
