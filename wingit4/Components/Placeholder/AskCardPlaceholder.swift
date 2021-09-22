//
//  AskCardPlaceholder.swift
//  wingit4
//
//  Created by Joshua Lee on 8/29/21.
//

import SwiftUI
//
//
struct AskCardPlaceholder: View {
  let postPlaceholder = Post(
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
  

    var body: some View {
        AskCard(
          post: postPlaceholder,
          isProfileView: true
        )
        .allowsHitTesting(false)
//        .foregroundColor(Color(.orange))
        .redacted(reason: .placeholder)
        .padding(.bottom, 15)
    }
}
