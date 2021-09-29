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
  var postOwnerId: String?
  var isOPComment: Bool = false
  

  
  @State var isNavActive: Bool = false


  
  init(comment: Comment, postOwnerId: String?) {
    self.comment = comment
    self.postOwnerId = postOwnerId
    if comment.ownerId == postOwnerId {
      self.isOPComment = true
    }
  }
  
    var body: some View {
      HStack(alignment: .top) {
        NavigationLink(
          destination: ProfileView(userId: comment.ownerId, user: nil),
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
          .onTapGesture(perform: { isNavActive.toggle() })

        VStack(alignment: .leading) {
          HStack(alignment: .center) {
              Text(comment.username ?? "")
              .font(.system(size:13))
              .fontWeight(.semibold)
//            UserCommentLabel(isOPComment: isOPComment)
            Circle()
            .modifier(CircleDotStyle())
            Text(
              timeAgoSinceDate(
                Date(timeIntervalSince1970: comment.date ?? 0),
                currentDate: Date(),
                numericDates: true
              )
            )
              .foregroundColor(.gray)
              .font(.system(size: 10))
            Image(systemName: "rosette")
              .foregroundColor(.wingitBlue)
              .font(.system(size:12))

          }
          .onTapGesture(perform: { isNavActive.toggle() })

          
            Text(comment.comment?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
            .font(.system(size:15))
            .padding(.top, 1)
          
          
          // Emoji Bar
          
        
          

        }
        .padding(.leading, 5)

        
        
      }
      .padding(15)
      .onTapGesture(perform: { isNavActive.toggle() })

      Divider()
    }
}


