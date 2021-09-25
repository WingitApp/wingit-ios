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
  @EnvironmentObject var mainViewModel: MainViewModel

  
  var body: some View {

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
      .onTapGesture {
        // we want to open referral tab on tap
        mainViewModel.setTab(tabId: 1)
      }
    
  }
}

struct NotificationES: View {
  var activity: Activity
  
  var body: some View {
    
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
}

