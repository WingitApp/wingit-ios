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
        ZStack {
          URLImageView(urlString: comment.avatarUrl)
            .clipShape(Circle())
            .frame(width: 30, height: 30, alignment: .center)
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(Color.white, lineWidth: 1)
            )
            .zIndex(0)
          URLImageView(urlString: comment.inviterAvatarUrl!)
            .clipShape(Circle())
            .frame(width: 20, height: 20, alignment: .center)
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(Color.white, lineWidth: 1)
            )
//            .shadow(
//              color: Color.black.opacity(0.3),
//              radius: 1, x: 0, y: -1
//            )
            .offset(x: 15, y: 10)
            .zIndex(1)
        }
        .padding(.trailing, 20)

        VStack(alignment: .leading) {
          HStack(spacing: 0) {
            Text("\(comment.username)")
              .bold()
              .onTapGesture {
                self.pushToOwner.toggle()
              }
            Text(" accepted ")
            Text("\(comment.inviterDisplayName!)'s")
              .bold()
              .onTapGesture {
                self.pushToInviter.toggle()
              }
            Text(" referral.")
          }
          .font(.caption2)
          .fixedSize(horizontal: false, vertical: true)
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
        Spacer()
      }
      .padding(.bottom, 10)
      .frame(
        maxWidth: UIScreen.main.bounds.width - 30
      )
    }
}
