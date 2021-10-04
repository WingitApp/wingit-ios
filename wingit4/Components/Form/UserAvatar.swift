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
    Haptic.impact(type: "soft")
    isTapped = true
  }
  
  var body: some View {
    NavigationLink(
      destination: ProfileView(userId: user.id, user: user),
      isActive: $isTapped
    ) {
      EmptyView()
    }
    .frame(width: 0, height: 0)
    .hidden()
    URLImageView(urlString: user.profileImageUrl)
      .clipShape(Circle())
      .frame(width: width, height: height)
      .modifier(RoundBorderStyle(color: Color.gray, lineWidth: 1))
      .onTapGesture(perform: onUserAvatarTap)
  }
}
