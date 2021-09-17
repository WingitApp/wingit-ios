//
//  ProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/13/21.
//

import SwiftUI

struct ProfileFeed: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
  /**these function are needed to keep posts sorted b/c
   posts are closed/opened at random sequences by user*/
    func sortOpenPosts() -> Void {
      self.profileViewModel.openPosts.sort { $0.date > $1.date }
    }
  
    func sortClosedPosts() -> Void {
      self.profileViewModel.closedPosts.sort { $0.date > $1.date }
    }
  

    var body: some View {
      
      if profileViewModel.showOpenPosts {
        if !profileViewModel.isLoading && profileViewModel.openPosts.count == 0 {
          if profileViewModel.closedPosts.count == 0 {
            /** State when user has not made any posts yet*/
            EmptyState(
              title: "Write your first post!",
              description: "Click on the Plus Tab to get started.",
              iconName: "pencil.and.outline",
              iconColor: Color(.systemTeal),
              function: nil
            )
          } else {
            /** State when user has closed every ask*/
            EmptyState(
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
          }.onAppear(perform: sortOpenPosts)
        }
      } else {
        if !profileViewModel.isLoading && profileViewModel.closedPosts.count == 0 {
          EmptyState(
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
          }.onAppear {
            sortOpenPosts()
            sortClosedPosts()
          }
        }
          
      }
   }
}

