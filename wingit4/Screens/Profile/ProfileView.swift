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
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @StateObject var connectionsViewModel = ConnectionsViewModel()

  
  
  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
     geometry.frame(in: .global).minY
  }
  
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = getScrollOffset(geometry)
      
      // Image was pulled down
      if offset > 0 {
          return -offset
      }
      
      return 0
  }
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
      let offset = getScrollOffset(geometry)
      let imageHeight = geometry.size.height

      if offset > 0 {
          return imageHeight + offset
      }

      return imageHeight
  }
  
  
  var body: some View {
    ScrollView {
      GeometryReader { geometry in
        URLImageView(inputURL: session.currentUser?.profileImageUrl)
          .scaledToFill()
          .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry)) // 2
          .clipped()
          .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
      }.frame(height: 300)
      ForEach(self.profileViewModel.posts.indices, id: \.self) { index in
          LazyVStack {
              AskCard(
                post: self.profileViewModel.posts[index],
                isProfileView: true,
                index: index
              )
//                .redacted(reason: self.profileViewModel.isLoading ? .placeholder : [])
            }
        }
    }.edgesIgnoringSafeArea(.all)
  }
}
//       var body: some View {
//
//        NavigationView {
//            ScrollView{
//                LazyVStack(alignment: .center, spacing: 15, pinnedViews: [.sectionHeaders], content: {
//                    ProfileCard()
//              //  Section(header: ProfileNavigation(user: self.session.userSession)) {
////                if !self.profileViewModel.posts.isEmpty {
//                      ForEach(self.profileViewModel.posts, id: \.postId) { post in
//                        LazyVStack {
////                            AskCard(post: post, isProfileView: true)
////                              .redacted(reason: self.profileViewModel.isLoading ? .placeholder : [])
//                          }
//                      }
//              //  }
//            })
//        }
//        .background(Color.black.opacity(0.03)
//        .ignoresSafeArea(.all, edges: .all))
//        .navigationBarTitle(Text("Profile"), displayMode: .inline).navigationBarItems(leading:
//                    Button(action: {}) {
//                        NavigationLink(destination: UsersView()) {
//                            Image(systemName: "person.badge.plus").imageScale(Image.Scale.large).foregroundColor(.gray)
//                        }
//                    },trailing:
//                    Button(action: {
//                        self.session.logout()
//
//                    }) {
//                       Label(title: { Text("Logout")},
//                             icon: {Image(systemName: "arrow.right.circle.fill")}).imageScale(Image.Scale.large).foregroundColor(.gray)
//
//                } )
//        }
//        .environmentObject(connectionsViewModel)
//      }
//}
