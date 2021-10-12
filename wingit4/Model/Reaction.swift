//
//  Reaction.swift
//  wingit4
//
//  Created by Joshua Lee on 9/29/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Reaction: Codable, Identifiable, Hashable, Equatable {
  @DocumentID var docId: String?
  var id: String?
  var emojiCode:  Int
  var commentId: String?
  var reactorId: String?
  var avatarUrl: String?
  var username: String?
  var createdAt: Double?
  var updatedAt: Double?
  var score: ReactionScore?
  var isOwn: Bool? {
    // returns if reaction is own
    guard let currentUser = Auth.auth().currentUser else { return false }
    return reactorId == currentUser.uid
  }
}

enum ReactionScore: Int, Codable {
    case negative = -1
    case neutral = 0
    case positive = 1
}
