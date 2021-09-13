//
//  ProfileFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 9/13/21.
//

import SwiftUI

struct ProfileFeed: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
      if profileViewModel.showOpenPosts {
        LazyVStack {
          ForEach(Array(profileViewModel.openPosts.enumerated()), id: \.element) { index, post in
              AskCard(
                post: post,
                isProfileView: true,
                index: index
              )
            }
        }
        .onAppear {
          self.profileViewModel.openPosts.sort {
            $0.date > $1.date
          }
        }
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
        .onAppear {
          self.profileViewModel.closedPosts.sort {
            $0.date > $1.date
          }
        }
      }
    }
}

struct ProfileFeed_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFeed()
    }
}
