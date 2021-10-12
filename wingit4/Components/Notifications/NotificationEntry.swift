//
//  NotificationEntry.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//
import FirebaseFirestore
import SwiftUI
import URLImage

struct NotificationEntry: View {
  var notification: Notification
  
  var body: some View {
    NavigationLink (destination: ProfileView(userId: notification.userId, user: nil)){
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

struct NotificationReferralEntry: View {
  @Binding var notification: Notification
  @EnvironmentObject var notificationViewModel: NotificationViewModel
  
  func routeToReferralView() {
    Haptic.impact(type: "soft")
    ViewRouter.shared.setTab(tab: .referrals)
    notification.openedAt = Timestamp(date: Date())
    notificationViewModel.updateOpenedAt(notificationId: notification.activityId)
  }
  
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
          view.background(Color.notificationBackground)
      }
      .onTapGesture(perform: routeToReferralView)
  }
}

struct NotificationES: View {
  var notification: Notification
  
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

      }
  
  }
}

