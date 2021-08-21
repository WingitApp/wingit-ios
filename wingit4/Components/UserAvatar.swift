//
//  UserAvatar.swift
//  wingit4
//
//  Created by Joshua Lee on 8/21/21.
//

import SwiftUI


struct UserAvatar: View {
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
