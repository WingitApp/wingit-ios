//
//  CommentNotification.swift
//  wingit4
//
//  Created by Daniel Yee on 9/29/21.
//

import FirebaseFirestore
import SwiftUI
import URLImage

struct CommentNotification: View {
    @Binding var notification: Notification
    @EnvironmentObject var notificationViewModel: NotificationViewModel
    
  var body: some View {
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
          Spacer()
      }
      .padding()
      .if(notification.openedAt == nil) { view in
          view.background(Color.skyBlue)
      }
      .onTapGesture {
          notification.openedAt = Timestamp(date: Date())
          notificationViewModel.updateOpenedAt(notificationId: notification.activityId)
          notificationViewModel.post = notification.post
          notificationViewModel.selectedNotificationType = .askDetail
          notificationViewModel.isNavigationLinkActive = true
      }
  }
}
