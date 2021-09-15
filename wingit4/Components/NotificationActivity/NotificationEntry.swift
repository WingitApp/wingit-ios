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
      HStack {
          NotificationUserAvatar(
           imageUrl: activity.userAvatar,
           type: activity.type
          )
         .padding(.trailing, 10)
          VStack(alignment: .leading, spacing: 5) {
              Text(activity.username).font(.subheadline).bold()
              Text(activity.typeDescription).font(.subheadline)
          }
        
          Spacer()
          TimeAgoStamp(date: activity.date)
      }
    }
    .buttonStyle(PlainButtonStyle())
      
  }
}
