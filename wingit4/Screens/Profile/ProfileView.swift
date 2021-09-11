//
//  ProfileView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth


//TODO: Refacor and reorganize

struct ProfileView: View {
  
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var profileViewModel: ProfileViewModel
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
  
  func openUpdatePicSheet() {
    self.profileViewModel.isUpdatePicSheetOpen.toggle()
  }
  
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        ZStack {
          GeometryReader { geometry in
            URLImageView(inputURL: session.currentUser?.profileImageUrl)
                .frame(
                  height: self.calculateHeight(
                    minHeight: 0,
                    maxHeight: 230,
                    yOffset: geometry.frame(in: .global).origin.y
                  )
                )
                .clipped()
                .offset(
                  y: geometry.frame(in: .global).origin.y < 0 // Is it going up?
                    ? abs(geometry.frame(in: .global).origin.y) // Push it down!
                    : -geometry.frame(in: .global).origin.y
                ) // Push it up!
                .blur(radius: 1)
          }
          .onTapGesture(perform: self.openUpdatePicSheet)
          .zIndex(0)
        
          
          VStack {
            URLImageView(inputURL: session.currentUser?.profileImageUrl)
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(100)
            .onTapGesture(perform: self.openUpdatePicSheet)
            .zIndex(2)
            .offset(y: -80)
            VStack {
              HStack {
                Button(action: {Api.User.updateField(field: "firstName", user: session.currentUser) }) {
                  Text(session.currentUser?.firstName ?? "").font(.title).bold().foregroundColor(Color("bw"))
                }
                
                Button(action: {Api.User.updateField(field: "lastName", user: session.currentUser) }) {
                  Text(session.currentUser?.lastName ?? "").font(.title).bold().foregroundColor(Color("bw"))
                }
              }.frame(width: UIScreen.main.bounds.width)
              
              Text(session.currentUser?.bio ?? "")
                .font(.subheadline)
                .italic()

              Connections(
                user: self.session.currentUser,
                connectionsCount: $profileViewModel.connectionsCountState
              )
              ProfileHeader(
                user: self.session.currentUser,
                postCount: profileViewModel.posts.count,
                doneCount: profileViewModel.doneposts.count
              )
            }
            .padding(.top, -80)
            .background(Color.white)
            .frame(width: UIScreen.main.bounds.width)
            
            LazyVStack {
              ForEach(profileViewModel.posts.indices, id: \.self) { index in
                  AskCard(
                    post: profileViewModel.posts[index],
                    isProfileView: false,
                    index: index
                  )
                }
            }
          }
          .zIndex(1)
          .padding(.top, 230)
        }
      }
      .background(
        Color.white.ignoresSafeArea(.all, edges: .all)
      )
      .sheet(
        isPresented: $connectionsViewModel.isConnectionsSheetOpen,
        content: {  ConnectionsView(user: session.currentUser).environmentObject(connectionsViewModel) }
      )
      .sheet(
        isPresented:  $profileViewModel.isUpdatePicSheetOpen,
        content: { ProfilePicToggle(user: session.currentUser) }
      )
      .environmentObject(connectionsViewModel)
      .navigationBarTitle(Text(session.currentUser?.displayName ?? "Profile"), displayMode: .inline)
      .navigationBarItems(leading:
      Button(action: {}) {
        NavigationLink(destination: UsersView()) {
          Image(systemName: "person.badge.plus")
            .imageScale(Image.Scale.large)
            .foregroundColor(.gray)
        }
      },trailing:
        Button(action: {
          self.session.logout()
          
        }) {
          Label(title: { Text("Logout")},
                icon: {Image(systemName: "arrow.right.circle.fill")}).imageScale(Image.Scale.medium).foregroundColor(.gray)
          
        } )
    }
  }
}
