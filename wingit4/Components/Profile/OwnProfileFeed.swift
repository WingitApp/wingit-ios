//
//  OwnProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 10/4/21.
//

import SwiftUI

struct OwnProfileFeed: View {
  @EnvironmentObject var profileViewModel: SessionStore
  
  func sortOpenPosts() -> Void {
    self.profileViewModel.openPosts.sort { $0.date ?? 0 > $1.date ?? 0 }
  }

  func sortClosedPosts() -> Void {
    self.profileViewModel.closedPosts.sort { $0.date ?? 0 > $1.date ?? 0 }
  }


    var body: some View {
      if profileViewModel.showOpenPosts {
        if !profileViewModel.isFetchingUserOpenPosts,
          !profileViewModel.isFetchingUserClosedPosts,
          profileViewModel.openPosts.count == 0
        {
          if profileViewModel.closedPosts.count == 0 {
            /** State when user has not made any posts yet*/
            PostEmptyState(
              title: "Write your first post!",
              description: "Click on the Plus Tab to get started.",
              iconName: "pencil.and.outline",
              iconColor: Color(.systemTeal),
              function: nil
            )
          } else {
            /** State when user has closed every ask*/
            PostEmptyState(
              title: "All done!",
              description: "All your asks have been closed.",
              iconName: "checkmark",
              iconColor: Color("Color1"),
              function: nil
            )
          }
          
        } else {
          LazyVStack {
            ForEach(Array(profileViewModel.openPosts.enumerated()), id: \.element) { index, post in
                AskCard(
                  post: post,
                  isProfileView: true,
                  index: index
                )

              }
          }
        }
      } else {
        if !profileViewModel.isFetchingUserOpenPosts,
          !profileViewModel.isFetchingUserClosedPosts,
          profileViewModel.closedPosts.count == 0
        {
          PostEmptyState(
            title: "Hm nothing was found...",
            description: "Close your posts to see them here!",
            iconName: "magnifyingglass",
            iconColor: Color(.systemBlue),
            function: nil
          )
        } else {
          LazyVStack {
            ForEach(Array(profileViewModel.closedPosts.enumerated()), id: \.element) { index, post in
                AskCard(
                  post: post,
                  isProfileView: true,
                  index: index
                )
              }
          }
        }
          
      }

    }
}
