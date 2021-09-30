//
//  NotificationEntry.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//
import SwiftUI
import URLImage

struct NotificationEntry: View {
  var notification: Notification
  
  var body: some View {
    NavigationLink (destination: UserProfileView(userId: notification.userId, user: nil)){
      HStack(alignment: .top) {
          NotificationUserAvatar(
             imageUrl: notification.userAvatar,
             type: notification.type
          )
         .padding(.trailing, 10)
          VStack(alignment: .leading, spacing: 5) {
            Group {
              Text("\(notification.username) ").font(.subheadline).bold() +
              Text(notification.typeDescription).font(.subheadline)
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
  var notification: Notification
  @EnvironmentObject var mainViewModel: MainViewModel

  
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
              Text(notification.typeDescription).font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
              Spacer()
              TimeAgoStamp(date: notification.date)
          }
      }
      .onTapGesture {
        // we want to open referral tab on tap
        mainViewModel.setTab(tabId: 1)
      }
    
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
              Text(notification.typeDescription).font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
              Spacer()
            TimeAgoStamp(date: notification.date)
          }

      }
  
  }
}

