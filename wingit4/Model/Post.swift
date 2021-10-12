//
//  Post.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct Post: Codable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    var caption: String?
    var location: String?
    var ownerId: String?
    var postId: String?
    var status: PostStatus?
    var username: String?
    var avatar: String?
    var mediaUrl: String?
    var date: Double?
    var title: String?
    var wingers: [User]?
    var type: PostType?
    var isOwn: Bool? {
      // returns if post is own
      guard let currentUser = Auth.auth().currentUser else { return false }
      return self.ownerId == currentUser.uid
    }
  var topCommentId: String?
}

enum PostType: String, Codable {
    case recommendations
    case advice
    case assistance
    case general
}

enum PostStatus: String, Codable {
    case open
    case closed
}
