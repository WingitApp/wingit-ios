//
//  UserAvatar.swift
//  wingit4
//
//  Created by Joshua Lee on 8/21/21.
//

import SwiftUI


struct UserAvatar: View {
  var user: User
  var height: CGFloat = 35
  var width: CGFloat = 35
  @State var isTapped: Bool = false
  
  func onUserAvatarTap() {
    isTapped = true
  }
  
  var body: some View {
    NavigationLink(
      destination: UserProfileView(userId: user.id, user: user),
      isActive: $isTapped
    ) {
      EmptyView()
    }
    URLImageView(urlString: user.profileImageUrl)
      .clipShape(Circle())
      .frame(width: width, height: height)
      .onTapGesture(perform: onUserAvatarTap)
  }
}
