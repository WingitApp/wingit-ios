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
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var connectionsViewModel = ConnectionsViewModel()

  
  func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
      // If scrolling up, yOffset will be a negative number
      if maxHeight + yOffset < minHeight {
          // SCROLLING UP
          // Never go smaller than our minimum height
          return minHeight
      }
      
      // SCROLLING DOWN
      return maxHeight + yOffset
  }
  
  

  var body: some View {
    ScrollView(showsIndicators: false) {
      ZStack {
        // Profile Header
        VStack {
          GeometryReader { geometry in
              Button(
                action: {  },
                label: {
                  URLImage(
                    URL(string: session.currentUser!.profileImageUrl)!,
                    content: {
                      $0.image
                        .resizable()
                        .scaledToFill()
                        .frame(height: self.calculateHeight(
                            minHeight: 0,
                            maxHeight: 280,
                            yOffset: geometry.frame(in: .global).origin.y)
                        )
                        .clipped()
                        .offset(
                          y: geometry.frame(in: .global).origin.y < 0 // Is it going up?
                              ? abs(geometry.frame(in: .global).origin.y) // Push it down!
                              : -geometry.frame(in: .global).origin.y
                        ) // Push it up!

                  })
                }
              )
              .buttonStyle(PlainButtonStyle())
          }
          .frame(height: 280)


          Spacer()
        }
        .zIndex(0)
        
        // Body
        VStack {
          HStack {
            
          }
          .fixedSize()
          .frame(height: 300)
          

          VStack {
//            URLImage(
//              URL(string: session.currentUser!.profileImageUrl)!,
//              content: {
//                $0.image
//                  .resizable()
//                  .scaledToFill()
//                  .clipShape(Circle())
//                  .overlay(
//                    RoundedRectangle(cornerRadius: 100)
//                      .stroke(Color.white, lineWidth: 3)
//                  )
//                  .background(Color.white)
//                  .frame(width: 100, height: 100)
//            })
//              .offset(y: 15)
            
            Button(action: {Api.User.updateDetails(field: "Name")}) {
              Text(session.currentUser!.username).font(.title).bold().foregroundColor(Color("bw"))
            }
            Button(action: {Api.User.updateDetails(field: "bio")}) {
              Text("@\(session.currentUser!.bio)").font(.caption).foregroundColor(.gray)
            }
            Connections(
              user: self.session.currentUser,
              connectionsCount: $profileViewModel.connectionsCountState
            )
            ProfileHeader(
              user: self.session.currentUser,
              postCount: profileViewModel.posts.count,
              doneCount: profileViewModel.doneposts.count
            )
            ForEach(self.homeViewModel.posts.indices, id: \.self) { index in
                AskCard(
                  post: self.homeViewModel.posts[index],
                  isProfileView: false,
                  index: index
                )
            }
          }
          .background(
            Color.white
              .cornerRadius(30, corners: [.topLeft, .topRight])
              .padding(.top, -40)
              .shadow(color: Color.black.opacity(0.2), radius: 10, x: 3, y: 3)
              
            )
         
        }
        .zIndex(1)

        
        // END
        // TOP PROFILEtac
        
//        VStack {
//                Image("Utah")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height:
//                        self.calculateHeight(minHeight: 120,
//                                             maxHeight: 300,
//                                             yOffset: gr.frame(in: .global).origin.y))
//                    .overlay(
//                        Text("UTAH")
//                            .font(.system(size: 70, weight: .black))
//                            .foregroundColor(.white)
//                            .opacity(0.8))
//                    // Offset just on the Y axis
//                    .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
//                        ? abs(gr.frame(in: .global).origin.y) // Push it down!
//                        : -gr.frame(in: .global).origin.y) // Push it up!
//
//                Spacer() // Push header to top
//            }
        

       
      }


    }
    .edgesIgnoringSafeArea(.all)
    .background(Color.white)
    .environmentObject(connectionsViewModel)
  }

}
//       var body: some View {
//
//        NavigationView {
//            ScrollView{
//                LazyVStack(alignment: .center, spacing: 15, pinnedViews: [.sectionHeaders], content: {
//                    ProfileCard()
//                Section(header: ProfileNavigation(user: self.session.userSession)) {
//                if !self.profileViewModel.posts.isEmpty {
//                      ForEach(self.profileViewModel.posts, id: \.postId) { post in
//                        LazyVStack {
//                            AskCard(post: post, isProfileView: true)
//                              .redacted(reason: self.profileViewModel.isLoading ? .placeholder : [])
//                          }
//                      }
//                }
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


