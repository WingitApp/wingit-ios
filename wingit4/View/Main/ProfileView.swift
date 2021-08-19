//
//  ProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var profileViewModel = ProfileViewModel()

    @State var postCountState = 0

    
       var body: some View {
         
        NavigationView {
            VStack(alignment: .leading, spacing: 15){
           ScrollView {
               VStack {
                ProfileInformation(user: self.session.userSession)
                Connections(user: self.session.userSession, followingCount: $profileViewModel.followingCountState, followersCount: $profileViewModel.followersCountState)
                ProfileHeader(user: self.session.userSession, postCount: profileViewModel.posts.count, doneCount: profileViewModel.doneposts.count)
            
               Divider()
                if !profileViewModel.isLoading {
<<<<<<< HEAD
                    if selection == .globe {
                        ForEach(self.profileViewModel.gemposts, id: \.postId) { gempost in
                            VStack {

                               gemHeader(gempost: gempost, isProfileView: true)

                            }
                        }

                    } else {
                        ForEach(self.profileViewModel.posts, id: \.postId) { post in
                            VStack {
                                HeaderCell(post: post, isProfileView: true)
                                FooterCell(post: post)
=======
                        ForEach(self.profileViewModel.posts, id: \.postId) { post in
                            VStack {
                                CardView(post: post)
>>>>>>> d7a8e17 (Profile Components change)
                            }
                        }
                    
                }
                }.padding(.top, 5)
                }
        }.padding(.top, 10)
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
                        
                } ).onAppear {
                    self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            }
        }
      }
}
