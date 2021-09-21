//
//  NotificationEntry.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//
import SwiftUI
import URLImage

struct NotificationEntry: View {
  var activity: Activity
  
  var body: some View {
    NavigationLink (destination: UserProfileView(userId: activity.userId, user: nil)){
      HStack(alignment: .top) {
          NotificationUserAvatar(
           imageUrl: activity.userAvatar,
           type: activity.type
          )
         .padding(.trailing, 10)
          VStack(alignment: .leading, spacing: 5) {
            Group {
              Text("\(activity.username) ").font(.subheadline).bold() +
              Text(activity.typeDescription).font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
              Spacer()
              TimeAgoStamp(date: activity.date)
          }

          
      }
    }
    .buttonStyle(PlainButtonStyle())
      
  }
}

struct NotificationReferralEntry: View {
  var activity: Activity
  
  var body: some View {
    
    NavigationLink (destination: ReferralsNotificationView()){
      HStack(alignment: .top) {
          NotificationUserAvatar(
           imageUrl: activity.userAvatar,
           type: activity.type
          )
         .padding(.trailing, 10)
          VStack(alignment: .leading, spacing: 5) {
            Group {
              Text("\(activity.username) ").font(.subheadline).bold() +
              Text(activity.typeDescription).font(.subheadline)
            }
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
              Spacer()
              TimeAgoStamp(date: activity.date)
          }

      }
    }
    .buttonStyle(PlainButtonStyle())
      
  }
}
