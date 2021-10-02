
//
//  ProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
//import SwiftUI
//import FirebaseAuth
//
//
////TODO: Refacor and reorganize
//struct ProfileView: View {
//
//  @EnvironmentObject var session: SessionStore
//  @EnvironmentObject var profileViewModel: ProfileViewModel
//  @StateObject var connectionsViewModel = ConnectionsViewModel()
//
//
//  func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
//    // If scrolling up, yOffset will be a negative number
//    if maxHeight + yOffset < minHeight {
//      // SCROLLING UP
//      // Never go smaller than our minimum height
//      return minHeight
//    }
//
//    // SCROLLING DOWN
//    return maxHeight + yOffset
//  }
//
//  func openUpdatePicSheet() {
//    self.profileViewModel.isUpdatePicSheetOpen.toggle()
//  }
//
//
//  var body: some View {
//    NavigationView {
//      ScrollView(showsIndicators: false) {
//        ZStack {
//          GeometryReader { geometry in
//            URLImageView(urlString: session.currentUser?.profileImageUrl)
//                .frame(
//                  height: self.calculateHeight(
//                    minHeight: 0,
//                    maxHeight: 230,
//                    yOffset: geometry.frame(in: .global).origin.y
//                  )
//                )
//                .clipped()
//                .offset(
//                  y: geometry.frame(in: .global).origin.y < 0
//                    ? abs(geometry.frame(in: .global).origin.y)
//                    : -geometry.frame(in: .global).origin.y
//                )
//                .blur(radius: 1)
//          }
//          .onTapGesture(perform: self.openUpdatePicSheet)
//          .zIndex(0)
//
//          VStack {
//            HStack {
//              URLImageView(urlString: session.currentUser?.profileImageUrl)
//                .frame(width: 150, height: 150)
//                .cornerRadius(100)
//                .padding(5)
//            }
//            .background(Color.white)
//            .cornerRadius(100)
//            .onTapGesture(perform: self.openUpdatePicSheet)
//            .zIndex(2)
//            .offset(y: -80)
//
//            Text("Add Connection")
//              .padding(.top, 5)
//              .padding(.bottom, 5)
//              .padding(.leading, 8)
//              .padding(.trailing, 8)
//              .clipShape(Capsule())
//            VStack {
//
//              HStack {
//                  Text(session.currentUser?.firstName ?? "").font(.title).bold().foregroundColor(Color.black)
//                  Text(session.currentUser?.lastName ?? "").font(.title).bold().foregroundColor(Color.black)
//                VStack {
////                  HStack(alignment: .top) {
////                    Image(systemName: "pencil")
////                      .frame(width: 10, height: 10)
////                      .imageScale(.small)
////                      .foregroundColor(Color.white)
////                      .padding(10)
////                      .background(Color.wingitBlue)
////                      .cornerRadius(100)
////                      .frame(width: 10, height: 10)
////                  }
//                }
//              }
//              .frame(width: UIScreen.main.bounds.width)
//              .background(
//                Color.white
//                 .cornerRadius(20, corners: [.topLeft, .topRight])
//                 .padding(.top, -105)
//               )
//              Text("@" + (session.currentUser?.username ?? ""))
//                .font(.subheadline)
//                .foregroundColor(Color.wingitBlue)
//
////                Button(action: {profileViewModel.isPresented.toggle()}){
////                    Text("Edit Profile")
////                }
//              Connections(
//                user: self.session.currentUser,
//                connectionsCount: profileViewModel.connections.count
//              )
//              .padding(.top, 5)
//              PersonalProfileHeader(
//                user: self.session.currentUser
//              )
//              .padding(.top, -3)
//            }
//            .padding(.top, -80)
//            .background(Color.white)
//            .frame(width: UIScreen.main.bounds.width)
//
//            ProfileFeed()
//
//
//          }
//          .zIndex(1)
//          .padding(.top, 230)
//
//        }
//
//        }
//      .background(
//        Color.white.ignoresSafeArea(.all, edges: .all)
//      )
//      .navigationBarTitle(
//        Text(session.currentUser?.displayName ?? "Profile"), displayMode: .inline
//      )
//      .navigationBarItems(
//        leading: Button(action: {}) {
//          NavigationLink(destination: UsersView()) {
//            Image(systemName: "magnifyingglass")
//              .imageScale(Image.Scale.medium)
//              .foregroundColor(.gray)
//          }
//        },
//        trailing:
//          Button(action: {
//            self.session.logout()
//
//          }) {
//              Text("Logout")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//              Image(systemName: "arrow.right.circle")
//                .imageScale(Image.Scale.medium)
//            .foregroundColor(.gray)
//        })
//    }
//    .environmentObject(connectionsViewModel)
//    .environmentObject(profileViewModel)
//    .sheet(
//      isPresented: $connectionsViewModel.isConnectionsSheetOpen,
//      content: {  ConnectionsView(
//        user: session.currentUser!).environmentObject(connectionsViewModel) }
//    )
//    .sheet(
//      isPresented:  $profileViewModel.isUpdatePicSheetOpen,
//      content: { UpdateProfilePhoto(user: session.currentUser) }
//    )
//    .modifier(Popup(
//      isPresented: profileViewModel.isEditSheetOpen,
//      alignment: .center,
//      direction: .bottom,
//      content: { EditProfileView().environmentObject(profileViewModel)}))
//  }
//}
