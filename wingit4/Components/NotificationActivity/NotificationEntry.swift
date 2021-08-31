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
      HStack {
          URLImage(
            URL(string: activity.userAvatar)!,
            content: {
               $0.image
               .resizable()
               .aspectRatio(contentMode: .fill)
               .clipShape(Circle())
          }).frame(width: 50, height: 50)
          VStack(alignment: .leading, spacing: 5) {
              Text(activity.username).font(.subheadline).bold()
              Text(activity.typeDescription).font(.subheadline)
          }
          Spacer()
          TimeAgoStamp(date: activity.date)
      }
  }
}
