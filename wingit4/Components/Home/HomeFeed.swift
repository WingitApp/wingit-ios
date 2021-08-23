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
      if homeViewModel.selection == .posts {
        ForEach(self.homeViewModel.posts, id: \.postId) { post in
          VStack {
            HeaderCell(
              post: post,
              isProfileView: false
            )
            FooterCell(post: post)
          }
          .padding(.top, 10)
          .redacted(
            reason: homeViewModel.isLoading ? .placeholder : []
          )
        }
      }
    }
  }
}


//         else if self.homeViewModel.selection == .globe {
//               ForEach(self.homeViewModel.gemposts, id: \.postId) { gempost in
//
//                   VStack {
//                       gemHeader(gempost: gempost, isProfileView: false)
//                     }.padding(.top, 10)
//                 }
//           }
 
