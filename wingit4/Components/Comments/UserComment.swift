//
//  Comment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import FirebaseAuth

struct UserComment: View {
  var comment: Comment
  var postOwnerId: String
  var isOPComment: Bool = false
  
  @State var isNavActive: Bool = false


  
  init(comment: Comment, postOwnerId: String) {
    self.comment = comment
    self.postOwnerId = postOwnerId
    if comment.ownerId == postOwnerId {
      self.isOPComment = true
    }
  }
  
    var body: some View {
      HStack(alignment: .top) {
//        NavigationLink(
//                  destination: UserProfileView(userId: comment.inviterId, user: nil),
//                  isActive: $pushToInviter
//                ) {
//                  EmptyView()
//                }
        NavigationLink(
          destination: UserProfileView(userId: comment.ownerId, user: nil),
          isActive: $isNavActive
        ) {
          EmptyView()
        }.hidden()
        URLImageView(urlString: comment.avatarUrl)
          .clipShape(Circle())
          .frame(width: 35, height: 35, alignment: .center)
            .foregroundColor(Color.wingitBlue)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.gray, lineWidth: 0.5)
          )
        VStack(alignment: .leading) {
          HStack(alignment: .center) {
            Text(comment.username)
              .font(.system(size:12))
              .fontWeight(.semibold)
//            UserCommentLabel(isOPComment: isOPComment)
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
          
          Text(comment.comment.trimmingCharacters(in: .whitespacesAndNewlines))
            .font(.system(size:14))
            .padding(.top, 1)

        }
        .padding(.leading, 5)
      }
      .padding(
        EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      )
      .onTapGesture(perform: { isNavActive.toggle() })
      Divider()
    }
}


