//
//  LikeButton.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI

struct LikeButton: View {
  @Binding var post: Post
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  
  func onTapGesture() {
    if self.footerCellViewModel.isLikedByUser {
      self.footerCellViewModel.unlike(post: post)
      post.likeCount -= 1
    } else {
      logToAmplitude(event: .upvote)
      self.footerCellViewModel.unlike(post: post)
      post.likeCount += 1
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
        if post.likeCount > 0 {
            Text("\(post.likeCount)").modifier(CaptionStyle())
        }
      }
      .onAppear{
   
      }
    }
}
