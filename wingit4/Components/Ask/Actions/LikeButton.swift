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
  @State var showLabel: Bool

  
  func onTapGesture() {
    if self.footerCellViewModel.isLikedByUser {
      self.footerCellViewModel.unlike(post: post)
      // update count
      post.likeCount -= 1
    } else {
      logToAmplitude(event: .upvote)
      self.footerCellViewModel.like(post: post)
      // update count
      post.likeCount += 1
    }
  }
  
    var body: some View {
      HStack {
        // Like Count - shows only if >= 1
//        Text("\(2200.formatUsingAbbrevation())")
//          .modifier(CaptionStyle())
//          .opacity(post.likeCount > 0 ? 1 : 0)
//          .padding(.trailing, -5)
        Image(systemName: self.footerCellViewModel.isLikedByUser
          ? "heart.fill"
          : "heart"
        )
        .onTapGesture(perform: onTapGesture)
        .foregroundColor(
          //todo fix like behavior
          self.footerCellViewModel.isLikedByUser ? .red : .gray
        )
        
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
      .onAppear{
        // move to top card
        self.footerCellViewModel.checkPostIsLiked(post: post)
      }
    }
}
