//
//  ReferalComment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI



struct ReferralComment: View {
    var comment: Comment
    @State var pushToInviter: Bool = false
    @State var pushToOwner: Bool = false
  
    var body: some View {
      HStack(alignment: .center) {
        NavigationLink(
          destination: UserProfileView(userId: comment.inviterId, user: nil),
          isActive: $pushToInviter
        ) {
          EmptyView()
        }
        NavigationLink(
          destination: UserProfileView(userId: comment.ownerId, user: nil),
          isActive: $pushToOwner
        ) {
          EmptyView()
        }
        HStack {
          Image(IMAGE_LOGO)
            .resizable()
            .scaledToFit()
            .frame(width: 23, height: 23)
        }
        .background(Color.white)
          .frame(width: 35, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .clipShape(Circle())
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
          

          HStack(spacing: 0) {
              Text("\(comment.inviterDisplayName ?? "Anon")")
                .bold()
                .onTapGesture {
                  self.pushToInviter.toggle()
                }
              Text(" invited ")
              Text("\(comment.username)")
                .bold()
                .onTapGesture {
                  self.pushToOwner.toggle()
                }
            Text(" to help.")
          }
          .font(.caption)
          .fixedSize(horizontal: false, vertical: true)

        }
        
        Spacer()
      }
      .padding(.top, 4)
      .padding(.leading, 10)
      Divider() //END
    }
}
