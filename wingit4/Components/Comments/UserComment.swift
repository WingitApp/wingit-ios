//
//  Comment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import URLImage

struct UserComment: View {
  var comment: Comment
  
    var body: some View {
      HStack(alignment: .top) {
        URLImage(URL(string: comment.avatarUrl)!,
          content: {
            $0.image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipShape(Circle())
          }
        )
        .frame(width: 25, height: 25, alignment: .center)
        .foregroundColor(Color(.systemTeal))
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.gray, lineWidth: 0.5)
        )
        VStack(alignment: .leading) {
          HStack(alignment: .center) {
            Text(comment.username)
              .font(.caption)
              .fontWeight(.semibold)
            Circle()
              .modifier(CircleDotStyle())
            Text(
              timeAgoSinceDate(
                Date(timeIntervalSince1970: comment.date),
                currentDate: Date(),
                numericDates: true
              )
            )
              .foregroundColor(.gray)
              .font(.system(size: 10))
          }
          Text(comment.comment)
            .font(.caption)
        }
        .padding(.leading, 10)
      }
      .padding(
        EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
      )
      Divider()
    }
}


