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
        VStack{
        Image("logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
        Text("No Posts! Connect with your friends")
            .font(.system(size: 12))
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .padding(.top, 25)
        }.background(Color.white)
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
