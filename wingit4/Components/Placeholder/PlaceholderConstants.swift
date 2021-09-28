//
//  PlaceholderConstants.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

class Placeholders {
    static let post = Post(
      caption: "This is a placeholder caption for a placeholer card.",
      likes: ["hello" : false],
      location: "",
      ownerId: "placeholder",
      postId: "anonymous_placeholder",
      username: "placeholder placeholder",
      avatar: "https://firebasestorage.googleapis.com:443/v0/b/wingitapp-1fe28.appspot.com/o/avatar%2F2RJzdK3G8hQPIHugFPvNWPWuRoI3?alt=media&token=74959a75-39a9-462e-b2a6-cb25931cf03e",
      mediaUrl: "",
      date: 1626821818.914922,
      likeCount: 0,
      type: PostType(rawValue: "recommendations")
    )
  
    static let referral = Referral(
      askId: "placeholder-referral-askid",
      recipientId: "placehodler-referral-recipientId",
      senderId:  "placeholder-referral-senderid",
      status: ReferralStatus.pending,
      text: "palceholder text"
    )
  
}
