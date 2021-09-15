//
//  NotificationUserAvatar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/14/21.
//

import SwiftUI

struct NotificationUserAvatar: View {

  var imageUrl: String = DEFAULT_PROFILE_AVATAR
//  var type?
  
    var body: some View {
      ZStack {
        URLImageView(urlString: imageUrl)
          .clipShape(Circle())
          .background(Color.white)
          .frame(width: 40, height: 40)
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
          .zIndex(0)
          Image(systemName: "bubble.right.fill")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(5)
            .background(Color(.systemTeal))
            .cornerRadius(100)
            .offset(x: 18, y: 13)
            .frame(width: 20, height: 20)
            .zIndex(1)
            
      }
    }
}
