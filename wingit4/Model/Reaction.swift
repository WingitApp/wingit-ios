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
  var createdAt: Double?
  var updatedAt: Double?
  var score: ReactionScore?
  var reactors: [String: UserPreview]
  var hasCurrentUser: Bool {
    guard let currentUser = Auth.auth().currentUser else { return false }
    return reactors[currentUser.uid] != nil
  }
  var count: Int {
    return reactors.keys.count
  }
}

enum ReactionScore: Int, Codable {
    case negative = -1
    case neutral = 0
    case positive = 1
}
