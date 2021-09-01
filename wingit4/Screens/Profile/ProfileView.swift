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
    @StateObject var connectionsViewModel = ConnectionsViewModel()
    
       var body: some View {
         
        NavigationView {
            ScrollView{
                LazyVStack(alignment: .center, spacing: 15, pinnedViews: [.sectionHeaders], content: {
                    ProfileCard()
              //  Section(header: ProfileNavigation(user: self.session.userSession)) {
//                if !self.profileViewModel.posts.isEmpty {
                      ForEach(self.profileViewModel.posts, id: \.postId) { post in
                        LazyVStack {
                            AskCard(post: post, isProfileView: true)
                          }
                      }
              //  }
            })
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
        .environmentObject(connectionsViewModel)
      }
}
