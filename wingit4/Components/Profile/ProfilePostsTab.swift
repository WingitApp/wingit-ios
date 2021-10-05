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
        if isOwnProfile {
          self.profileViewModel.showOpenPosts = true
        } else {
          self.userProfileViewModel.showOpenPosts = true
        }
    }
  
    func onTapShowClosedPosts() -> Void {
        if isOwnProfile {
          self.profileViewModel.showOpenPosts = false
        } else {
          self.userProfileViewModel.showOpenPosts = false
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
//                .fontWeight(
//                  isOwnProfile
//                  ? (profileViewModel.showOpenPosts ? .bold : .regular)
//                  : (userProfileViewModel.showOpenPosts ? .bold : .regular)
//                )
            }
            .foregroundColor(
              isOwnProfile
              ? (profileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
              : (userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
            )
          
        }
        .buttonStyle(PlainButtonStyle())
        .redacted(reason:
            (isOwnProfile ? profileViewModel.isFetchingUserOpenPosts : userProfileViewModel.isFetchingOpenPosts)
              ? .placeholder
              : []
          )
        
        Button( action: onTapShowClosedPosts) {
          HStack(alignment: .center, spacing: 5) {
            Text(isOwnProfile
                 ? String(profileViewModel.closedPosts.count)
                 : String(userProfileViewModel.closedPosts.count)
            ).bold()
            Text("Closed Posts")
//              .fontWeight(
//                isOwnProfile
//                ? (!profileViewModel.showOpenPosts ? .bold : .regular)
//                : (!userProfileViewModel.showOpenPosts ? .bold : .regular)
//              )
          }
          .foregroundColor(
            isOwnProfile
            ? (!profileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
            : (!userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
          )
        }
        .buttonStyle(PlainButtonStyle())
        .redacted(reason:
            (isOwnProfile ? profileViewModel.isFetchingUserClosedPosts : userProfileViewModel.isFetchingClosedPosts)
              ? .placeholder
              : []
          )
        
      }
      .font(.subheadline)
      .padding(.bottom, 15)
    }
}

