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
    if homeViewModel.emptyState == true {
        Text("No Posts! Connect with your friends")
    } else {
        ScrollView(showsIndicators: false) {
          LazyVStack {
            ForEach(Array(homeViewModel.posts.enumerated()), id: \.element) { index, post in
                AskCard(
                  post: post,
                  isProfileView: false,
                  index: index
                )
                .onAppear {
                  homeViewModel.loadMoreContentIfNeeded(
                    currentItem: post
                  )
                }
              
              }
          }
        }
    }

  }
}
