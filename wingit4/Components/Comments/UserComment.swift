//
//  Comment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct UserComment: View {
  var comment: Comment
  @State var isNavActive: Bool = false
  
  
    var body: some View {
      HStack(alignment: .top) {
        NavigationLink(
          destination: UserProfileView(userId: comment.ownerId, user: nil),
          isActive: $isNavActive
        ) {
          EmptyView()
        }
        URLImageView(urlString: comment.avatarUrl)
          .clipShape(Circle())
          .frame(width: 35, height: 35, alignment: .center)
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
            .font(.callout)
        }
        .padding(.leading, 5)

      }
      .padding(
        EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
      )
      .onTapGesture(perform: { isNavActive.toggle() })
      Divider()
    }
}


