//
//  ProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileViewModel: ProfileViewModel

    
       var body: some View {
         
        NavigationView {
            VStack(alignment: .leading, spacing: 15){
           ScrollView {
            VStack{
                ProfileInformation(user: self.session.userSession)
                Connections(
                  user: self.session.userSession,
                  followingCount: $profileViewModel.followingCountState,
                  followersCount: $profileViewModel.followersCountState
                )
                ProfileHeader(
                  user: self.session.userSession,
                  postCount: profileViewModel.posts.count,
                  doneCount: profileViewModel.doneposts.count
                )
       
//                if !self.profileViewModel.posts.isEmpty {
                      ForEach(self.profileViewModel.posts, id: \.postId) { post in
                        LazyVStack {
                            AskCard(post: post, isProfileView: true)
                          }
                      }
                  
//                }
                }
           }
        }
        .background(Color.black.opacity(0.03)
        .ignoresSafeArea(.all, edges: .all))
         .navigationBarTitle(Text("Profile"), displayMode: .inline).navigationBarItems(leading:
                    Button(action: {}) {
                        NavigationLink(destination: UsersView()) {
                            Image(systemName: "person.badge.plus").imageScale(Image.Scale.large).foregroundColor(.gray)
                        }
                    },trailing:
                    Button(action: {
                        self.session.logout()
                        
                    }) {
                       Label(title: { Text("Logout")},
                             icon: {Image(systemName: "arrow.right.circle.fill")}).imageScale(Image.Scale.large).foregroundColor(.gray)
                        
                } )
        }
      }
}
