//
//  NotificationEntry.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//

import SwiftUI
import URLImage

struct NotificationEntry: View {
  var activity: ActivityEvent
  
  var body: some View {
      HStack {
          URLImage(
            URL(string: activity.mediaUrl ?? "")!,
            content: {
               $0.image
               .resizable()
               .aspectRatio(contentMode: .fill)
               .clipShape(Circle())
          }).frame(width: 50, height: 50)
          VStack(alignment: .leading, spacing: 5) {
              Text(activity.connectionName ?? "").font(.subheadline).bold()
              Text(activity.notificationMessage).font(.subheadline)
          }
          Spacer()
        TimeAgoStamp(date: Double(activity.createdAt?.seconds ?? 0))
      }
  }
}
