//
//  UserProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 10/4/21.
//

import SwiftUI

struct UserProfileFeed: View {
  @EnvironmentObject var userProfileViewModel: UserProfileViewModel
  
  func sortOpenPosts() -> Void {
    self.userProfileViewModel.openPosts.sort { $0.date > $1.date }
  }

  func sortClosedPosts() -> Void {
    self.userProfileViewModel.closedPosts.sort { $0.date > $1.date }
  }

  
    var body: some View {
      if userProfileViewModel.showOpenPosts {
        if !userProfileViewModel.isFetchingOpenPosts,
            !userProfileViewModel.isFetchingClosedPosts,
            userProfileViewModel.openPosts.count == 0
        {
                  if userProfileViewModel.closedPosts.count == 0 {
                      PostEmptyState(
                        title: "Hm nothing was found...",
                        description: "\(userProfileViewModel.user.displayName!) has no posts.",
                        iconName: "magnifyingglass",
                        iconColor: Color(.systemBlue),
                        function: nil
                      )
                  } else {
                      PostEmptyState(
                        title: "Hm nothing was found...",
                        description: "\(userProfileViewModel.user.displayName!) has no open posts.",
                        iconName: "checkmark",
                        iconColor: Color("Color1"),
                        function: nil
                      )
                    }
              } else {
                  LazyVStack {
                    ForEach(Array(userProfileViewModel.openPosts.enumerated()), id: \.element) { index, post in
                        AskCard(
                          post: post,
                          isProfileView: true,
                          index: index
                        )
                      }
                  }
              }
          } else {
              if !userProfileViewModel.isFetchingOpenPosts,
                 !userProfileViewModel.isFetchingClosedPosts,
                 userProfileViewModel.closedPosts.count == 0
            {
                  PostEmptyState(
                    title: "Hm nothing was found...",
                    description: "\(userProfileViewModel.user.displayName!) has no closed posts.",
                    iconName: "magnifyingglass",
                    iconColor: Color(.systemBlue),
                    function: nil
                  )
              } else {
                  LazyVStack {
                    ForEach(Array(userProfileViewModel.closedPosts.enumerated()), id: \.element) { index, post in
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
