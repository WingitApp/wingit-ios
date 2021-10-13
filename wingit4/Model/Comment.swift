//
//  Comment.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Comment: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var docId: String?
    var id: String?
    var comment: String?
    var avatarUrl: String?
    var inviterAvatarUrl: String?
    var inviterDisplayName: String?
    var inviterId: String?
    var ownerId: String?
    var postId: String?
    var username: String?
    var date: Double?
    var type: CommentType?
    var isOwn: Bool? {
      guard let currentUser = Auth.auth().currentUser else { return false }
      return self.ownerId == currentUser.uid
    }
    // added for editing
    var isEdited: Bool?
    var updatedAt: Double?
}

enum CommentType: String, Codable {
    case askPost
    case invitedReferral
}
