//
//  UserAvatarSignup.swift
//  wingit4
//
//  Created by Daniel Yee on 9/22/21.
//

import SwiftUI


struct UserAvatarSignup: View {
  var image: Image
  var height: CGFloat = 35
  var width: CGFloat = 35
  var onTapGesture: () -> Void
  
  func onUserAvatarTap() {
    onTapGesture()
  }
  
  var body: some View {
    image
      .resizable()
      .aspectRatio(contentMode: .fill)
      .clipShape(Circle())
      .frame(width: width, height: height)
      .onTapGesture {
        onUserAvatarTap()
      }
  }
}
