//
//  ClosedPostsView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/11/21.
//

import Foundation

import SwiftUI
import FirebaseAuth

struct UserProfileClosedPostsView: View {
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    var user: User

    var body: some View {
        ScrollView{
            LazyVStack {
              ForEach(userProfileViewModel.closedPosts.indices, id: \.self) { index in
                  AskCard(
                    post: userProfileViewModel.closedPosts[index],
                    isProfileView: true,
                    index: index
                  )
                }
            }
        }
        .background(Color.black.opacity(0.03)
        .ignoresSafeArea(.all, edges: .all))
        .padding(.top, 10)
        .onAppear {
            logToAmplitude(event: .viewOtherUsersClosedAsks, properties: [.userId: user.id])
            self.userProfileViewModel.loadClosedPosts(userId: user.id)
        }
    }
}

