//
//  UserRow.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI
import URLImage

struct UserRow: View {
  
  var urlString: String
  var userDisplayName: String
  var username: String

    var body: some View {
//      HStack {
          URLImageView(urlString: urlString)
            .clipShape(Circle())
            .frame(width: 40, height: 40)
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(Color.gray, lineWidth: 0.5)
            )
          
          VStack(alignment: .leading, spacing: 5) {
           Text(userDisplayName)
            .font(.headline).bold()
            Text("@\(username)")
              .font(.subheadline)
              .foregroundColor(.wingitBlue)
          }
     
      //}
    }
}
