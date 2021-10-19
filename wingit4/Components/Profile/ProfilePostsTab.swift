//
//  ProfileConnections.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfilePostsTab: View {
    @EnvironmentObject var profileViewModel: SessionStore // moved user metadata to sessionStore
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel

    var isOwnProfile: Bool

    func onTapShowOpenPosts() -> Void {
        if isOwnProfile {
          self.profileViewModel.showOpenPosts = true
          self.profileViewModel.openPosts.sort { $0.date ?? 0 > $1.date ?? 0 }
          logToAmplitude(event: .viewOwnOpenAsks)
        } else {
          self.userProfileViewModel.showOpenPosts = true
          self.userProfileViewModel.openPosts.sort { $0.date ?? 0 > $1.date ?? 0 }
          logToAmplitude(event: .viewOtherUsersOpenAsks, properties: [.userId: userProfileViewModel.user.id])
        }
    }
  
    func onTapShowClosedPosts() -> Void {
        if isOwnProfile {
          self.profileViewModel.showOpenPosts = false
          logToAmplitude(event: .viewOwnClosedAsks)
        } else {
          self.userProfileViewModel.showOpenPosts = false
          logToAmplitude(event: .viewOtherUsersClosedAsks, properties: [.userId: userProfileViewModel.user.id])
        }
    }
  
    var body: some View {
      // user connections
      HStack(alignment: .center, spacing: 20){
          HStack(alignment: .center, spacing: 5) {
            Text(isOwnProfile
                 ? String(profileViewModel.openPosts.count)
                 : String(userProfileViewModel.openPosts.count)
            ).bold()
            Text("Open Posts")
          }
          .foregroundColor(
            isOwnProfile
            ? (profileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
            : (userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.black)
          )
          .onTapGesture(perform: onTapShowOpenPosts)
          .redacted(reason:
              (isOwnProfile ? profileViewModel.isFetchingUserOpenPosts : userProfileViewModel.isFetchingOpenPosts)
                ? .placeholder
                : []
            )
        
          HStack(alignment: .center, spacing: 5) {
            Text(isOwnProfile
                 ? String(profileViewModel.closedPosts.count)
                 : String(userProfileViewModel.closedPosts.count)
            ).bold()
            Text("Closed Posts")
          }
          .onTapGesture(perform: onTapShowClosedPosts)
          .foregroundColor(
            isOwnProfile
            ? (!profileViewModel.showOpenPosts ? Color.wingitBlue : Color.gray)
            : (!userProfileViewModel.showOpenPosts ? Color.wingitBlue : Color.gray)
          )
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
