//
//  LikeButton.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI

struct LikeButton: View {
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel

  
  @Binding var post: Post
  @State var showLabel: Bool = false

  
  func onTapGesture() {
    if self.footerCellViewModel.isLikedByUser {
      post.likeCount -= 1
      self.footerCellViewModel.unlike(post: post)
      // update count
    } else {
      logToAmplitude(event: .upvote)
      post.likeCount += 1
      self.footerCellViewModel.like(post: post)
      // update count
    }
  }
  
    var body: some View {
      HStack {
        Image(systemName: self.footerCellViewModel.isLikedByUser
          ? "heart.fill"
          : "heart"
        )
        .onTapGesture(perform: onTapGesture)
        .foregroundColor(
          self.footerCellViewModel.isLikedByUser ? .red : .gray
        )
        Text("\(post.likeCount.formatUsingAbbrevation())")
          .modifier(CaptionStyle())
          .font(.caption)
          .opacity(post.likeCount > 0 ? 1 : 0)
        if self.showLabel {
          Text(self.footerCellViewModel.isLikedByUser ? "Liked" : "Like ")
            .font(.caption)
            .padding(.leading, -2)
        }
      }
      .modifier(ActionIconStyle())
      .transition(
        .asymmetric(
          insertion: .opacity, removal: .scale)
      )
    }
}
