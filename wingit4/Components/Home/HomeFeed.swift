//
//  HomeFeed.swift
//  wingit4
//
//  Created by Joshua Lee on 8/22/21.
//

import SwiftUI

struct HomeFeed: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  @State var isInTransition: Bool = true

  var body: some View {
    ScrollView(showsIndicators: false) {
      LazyVStack {
          ForEach(self.homeViewModel.posts, id: \.postId) { post in
            AskCard(
              post: post,
              isProfileView: false
            )
            .onAppear { homeViewModel.loadMoreContentIfNeeded(currentItem: post) }
          }
      }
    }
  }
}
