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
    // Menu
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
    @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
    // Comment
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var referViewModel = ReferViewModel()
    @StateObject var commentInputViewModel = CommentInputViewModel()
    // Like
    @StateObject var footerCellViewModel = FooterCellViewModel()
    @EnvironmentObject var notificationViewModel: NotificationViewModel
    
  var body: some View {
      NavigationLink(
        destination: AskDetailView(post: $notification.post)
          .environmentObject(askCardViewModel)
          .environmentObject(askMenuViewModel)
          .environmentObject(askDoneToggleViewModel)
          .environmentObject(commentViewModel)
          .environmentObject(commentInputViewModel)
          .environmentObject(footerCellViewModel)
          .onAppear {
              notification.openedAt = Timestamp(date: Date())
              self.notificationViewModel.updateOpenedAt(notificationId: notification.activityId)
          })
      {
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
