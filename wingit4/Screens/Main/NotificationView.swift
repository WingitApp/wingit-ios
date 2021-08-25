//
//  NotificationView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
struct NotificationView: View {
    
    @ObservedObject var activityViewModel = ActivityViewModel()

    
    var body: some View {
       
        NavigationView {
            List {
                if !activityViewModel.activityArray.isEmpty {
                    ForEach(self.activityViewModel.activityArray, id: \.activityId) { activity in
                          HStack {
                            if activity.type == "comment" {
                                ZStack {
                                    CommentActivityRow(activity: activity)
                                  //todo
//                                    NavigationLink(destination: CommentView(postId: activity.postId)) {
//                                        EmptyView()
//                                    }
                                }
                                
                            } 
                            else {
                                URLImage(URL(string: activity.userAvatar)!,
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
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                            }
                       

                        }.padding(10)
                    }
                }
                  
           
            }.navigationBarTitle(Text("Notifications"), displayMode: .automatic).onAppear {
                  self.activityViewModel.loadActivities()
             }
            .onDisappear {
                 if self.activityViewModel.listener != nil {
                     self.activityViewModel.listener.remove()

                 }
              }

        }
      
    }
}

struct CommentActivityRow: View {
    var activity: Activity
    var body: some View {
        HStack {
            URLImage(URL(string: activity.userAvatar)!,
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
            Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
        }
    }
}


