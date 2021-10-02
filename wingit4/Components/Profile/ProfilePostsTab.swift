//
//  ProfileConnections.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfilePostsTab: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
  
    var isOwnProfile: Bool


    func onTapShowOpenPosts() -> Void {
      withAnimation {
        self.profileViewModel.showOpenPosts = true
      }
    }
  
    func onTapShowClosedPosts() -> Void {
      withAnimation {
        self.profileViewModel.showOpenPosts = false
      }
    }
  
    var body: some View {
      // user connections
      HStack(alignment: .center, spacing: 20){
        Button( action: onTapShowOpenPosts ) {
            HStack(alignment: .center, spacing: 5) {
              Text(isOwnProfile
                   ? String(profileViewModel.openPosts.count)
                   : String(userProfileViewModel.openPosts.count)
              ).bold()
              Text("Open Posts")
                  .bold()
            }
            .foregroundColor(
              isOwnProfile
              ? (profileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
              : (userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
            )
          
        }.buttonStyle(PlainButtonStyle())
        
        Button( action: onTapShowClosedPosts) {
          HStack(alignment: .center, spacing: 5) {
            Text(isOwnProfile
                 ? String(profileViewModel.closedPosts.count)
                 : String(userProfileViewModel.closedPosts.count)
            ).bold()
            Text("Closed Posts")
              .bold()
          }
          .foregroundColor(
            isOwnProfile
            ? (!profileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
            : (!userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
          )
        }.buttonStyle(PlainButtonStyle())
        
      }
      .font(.subheadline)
      .padding(.bottom, 15)
    }
}

