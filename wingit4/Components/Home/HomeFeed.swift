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

    if homeViewModel.posts.count == 0 {
        NavigationLink(destination: UsersView()) {
            EmptyState(
              title: "No posts!",
              description: "Tap here and connect with your friends to start the chain.",
              iconName: "person.badge.plus",
              iconColor: Color("Color1"),
              function: nil
            )
        }.buttonStyle(PlainButtonStyle())
       
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
        .padding(.top, -25)
    }

  }
}
