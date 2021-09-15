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
        
        HStack {
          Image(IMAGE_LOGO)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
        }
          .clipShape(Circle())
        .background(Color.white)
          .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.wingitBlue, lineWidth: 1)
          )
          .padding(.trailing, 10)
        VStack(alignment: .leading) {
          Text(
            timeAgoSinceDate(
              Date(timeIntervalSince1970: comment.date),
              currentDate: Date(),
              numericDates: true
            )
          )
          .foregroundColor(.gray)
          .font(.system(size: 10))
          Spacer()
          Group {
            Text("\(comment.inviterDisplayName ?? "Anon")").bold() +
            Text(" invited ") +
            Text("\(comment.username)").bold() +
            Text(" to help.")
          }.font(.caption)
        }
        
        Spacer()
      }
      .padding(.leading, 10)
      Divider() //END
    }
}
