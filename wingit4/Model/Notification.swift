//
//  Activity.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import FirebaseFirestore
import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Notification: Codable, Equatable, Identifiable {
  @DocumentID var id: String?
  var post: Post?
  var openedAt: Timestamp?
  
  // legacy fields
  var activityId: String
  var comment: String
  var date: Double
  var mediaUrl: String
  var postId: String
  var type: String
  var userAvatar: String
  var userId: String
  var username: String
    
  var typeDescription: String? {
      var output = ""
      switch type {
      case "comment":
          output = "replied: \(comment)"
      case "referred":
          output = "has referred you to help."
      case "follow":
          output = "is following you."
      case "like":
          output = "liked your post!"
      case "likeAsk":
          output = "liked your post!"
      case "connectRequest":
          output = "wants to connect with you!"
      case "connectRequestAccepted":
          output = "accepted your connect request!"
      default:
          output = ""
      }

      return output
  }
    
  enum CodingKeys: String, CodingKey {
      case activityId
      case comment
      case date
      case mediaUrl
      case openedAt
      case postId
      case type
      case userAvatar
      case userId
      case username
  }
  
  enum NotificationType: String {
    case connectRequest
    case connectRequestAccepted
    case referred
    case comment
  }
}
