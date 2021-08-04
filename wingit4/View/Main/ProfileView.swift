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
    @State var selection: Selection = .globe

    
       var body: some View {
         
        NavigationView {
            VStack(alignment: .leading, spacing: 15){
                Picker(selection: $selection, label: Text("Grid or Table")) {
                   ForEach(Selection.allCases) { selection in
                       selection.image.tag(selection)

                   }
                }.pickerStyle(SegmentedPickerStyle()).padding(.leading, 20).padding(.trailing, 20).background(Color.clear)
           ScrollView {
               VStack {
            
                ProfileHeader(user: self.session.userSession, postCount: profileViewModel.posts.count, gemPostCount: profileViewModel.gemposts.count, doneCount: profileViewModel.doneposts.count, followingCount: $profileViewModel.followingCountState, followersCount: $profileViewModel.followersCountState)
            
               Divider()
                if !profileViewModel.isLoading {
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
                            }
                        }
                    }
                }
                }.padding(.top, 5)
                }
        }.padding(.top, 10)
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
