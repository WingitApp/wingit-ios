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
  
  // emoji
  @State var text: String = ""
  var emojiList: [String] = ["😀", "🦄"]
  
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
              .font(.system(size:12))
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
            .font(.system(size:14))
            .padding(.top, 1)
          
          
          // Emoji Bar
          
          HStack {
            ForEach(self.emojiList.indices, id: \.self) { index in
              HStack(alignment: .center){
                Text("\(self.emojiList[index])")
                  .font(.system(size: 10))

                Text("3")
                  .font(.caption)
                  .font(.system(size: 10))
              }
              .padding(3)
              .background(Color.lightGray)
              .cornerRadius(5)

            }
            
            Image(systemName: "plus")
              .padding(3)
              .background(Color.lightGray)
              .cornerRadius(100)
              .font(.system(size: 10))
            
//            EmojiTextField(text: $text, placeholder: "Enter emoji")


          }
          

        }
        .padding(.leading, 5)

        
        
      }
<<<<<<< HEAD
      .padding(15)
      .onTapGesture(perform: { isNavActive.toggle() })
=======
      .padding(
        EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      )
>>>>>>> 4b8918d (add mock reactions comment bar)
      Divider()
    }
}


