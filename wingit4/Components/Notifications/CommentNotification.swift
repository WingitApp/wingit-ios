//
//  CommentNotification.swift
//  wingit4
//
//  Created by Daniel Yee on 9/29/21.
//
import SwiftUI
import URLImage

struct CommentNotification: View {
  @State var notification: Notification
  
  var body: some View {
      NavigationLink(destination: AskDetailView(post: $notification.post)) {
      HStack(alignment: .top) {
          NotificationUserAvatar(
             imageUrl: notification.userAvatar,
             type: notification.type
          )
         .padding(.trailing, 10)
          VStack(alignment: .leading, spacing: 5) {
            Group {
              Text("\(notification.username) ").font(.subheadline).bold() +
              Text(notification.typeDescription ?? "").font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
              Spacer()
            TimeAgoStamp(date: notification.date)
          }

          
      }
    }
    .buttonStyle(PlainButtonStyle())
      
  }
}
