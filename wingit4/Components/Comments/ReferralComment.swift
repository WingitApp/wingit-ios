//
//  ReferalComment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI



struct ReferralComment: View {
    var comment: Comment
  
    var body: some View {
      HStack(alignment: .center) {
        URLImageView(urlString: comment.avatarUrl)
          .frame(width: 23, height: 23, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(Color(.systemTeal))
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
        URLImageView(urlString: comment.inviterAvatarUrl)
          .frame(width: 23, height: 23, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(.pink)
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
          .padding(.leading, -15)
        Group {
          Text("\(comment.inviterDisplayName ?? "Anon")").bold() +
          Text(" invited ") +
          Text("\(comment.username)").bold() +
          Text(" to help.")
        }.font(.caption)
        Spacer()
      }
      .padding(.leading, 10)
      Divider() //END
    }
}
