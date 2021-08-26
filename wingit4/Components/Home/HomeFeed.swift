//
//  HomeFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 8/22/21.
//

import SwiftUI

struct HomeFeed: View {
  @EnvironmentObject var homeViewModel: HomeViewModel

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(self.homeViewModel.posts, id: \.postId) { post in
          AskCard(
            post: post,
            isProfileView: false
          ).redacted(reason: homeViewModel.isLoading ? .placeholder : [])
        }
      }
    }
  }
}
