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
   // @State var wasOpened: Bool = false
  
  var body: some View {
      NavigationLink(
        destination: AskDetailView(post: $notification.post)
          .environmentObject(askCardViewModel)
          .environmentObject(askMenuViewModel)
          .environmentObject(askDoneToggleViewModel)
          .environmentObject(commentViewModel)
          .environmentObject(commentInputViewModel)
          .environmentObject(footerCellViewModel),
  label:{
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
      .onTapGesture{
          self.notificationViewModel.updateWasOpened(notificationId: notification.activityId)
          notification.wasOpened = true
      }
         
    })
        
    .buttonStyle(PlainButtonStyle())
    .opacity(self.notification.wasOpened ?? false ?
             0.6 : 1)
      
      
  }
}
