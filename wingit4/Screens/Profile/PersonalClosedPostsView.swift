//
//  ClosedPostsView.swift
//  wingit4
//
//  Created by Daniel Yee on 9/11/21.
//

import Foundation

import SwiftUI
import FirebaseAuth

struct PersonalClosedPostsView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    var user: User

    var body: some View {
        ScrollView{
            LazyVStack {
              ForEach(profileViewModel.closedPosts.indices, id: \.self) { index in
                  AskCard(
                    post: profileViewModel.closedPosts[index],
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
            logToAmplitude(event: .viewOwnClosedAsks)
            self.profileViewModel.loadClosedPosts()
        }
    }
}
