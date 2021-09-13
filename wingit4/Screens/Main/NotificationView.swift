//
//  NotificationView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
import SwiftUI

struct NotificationView: View {
    
    @EnvironmentObject var activityViewModel: ActivityViewModel

    var body: some View {
       
        NavigationView {
            List {
                if !activityViewModel.activityArray.isEmpty {
                    ForEach(self.activityViewModel.activityArray, id: \.activityId) { activity in
                      HStack(alignment: .top) {
                            if activity.type == "comment" {
//                              NavigationLink(destination: AskDetailView)
                                    NotificationEntry(activity: activity)
//                                    NavigationLink(destination: CommentView(postId: activity.postId)) {
//                                        EmptyView()
//                                    }
                            } else if activity.type == "connectRequest" {
                                ZStack {
                                    CommentActivityRow(
                                      activity: activity,
                                      activityViewModel: self.activityViewModel
                                    )
                                }
                            } else {
                              NavigationLink (destination: UserProfileView(userId: activity.userId, user: nil)){
                                URLImageView(urlString: activity.userAvatar)
                                  .clipShape(Circle())
                                  .frame(width: 35, height: 35)
                                  .overlay(
                                    RoundedRectangle(cornerRadius: 100)
                                      .stroke(Color.gray, lineWidth: 1)
                                  )
                              VStack(alignment: .leading) {
                                HStack(alignment: .center, spacing: 5) {
                                  Text(activity.username).bold() + Text(" ") + Text(activity.typeDescription)
                                }
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)

                                Spacer()
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                              }
                              .padding(.leading, 3)
                                
                               
                            }                          .buttonStyle(PlainButtonStyle())

                          }


                        }
                        .padding(
                          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                        )
                    }
                }
                  
           
            }.navigationBarTitle(Text("Notifications"), displayMode: .inline)
            .onAppear {
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
    var activityViewModel: ActivityViewModel
    var body: some View {

        HStack(alignment: .top) {
          NavigationLink (destination: UserProfileView(userId: activity.userId, user: nil)){
            URLImageView(urlString: activity.userAvatar)
                .clipShape(Circle())
                .frame(width: 35, height: 35)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.gray, lineWidth: 1)
                )
          }
          .buttonStyle(FlatLinkStyle())
          HStack{
              VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 5) {
                  Text(activity.username).bold() + Text(" ") + Text(activity.typeDescription)
                }
                .frame(width: UIScreen.main.bounds.width)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                VStack(alignment: .leading) {
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    Spacer()
                      RespondToConnectRequestRow(activity: activity)
                  }
                  .padding(.top, 3)
              }
          }
          .padding(.leading, 5)
          }

    }
}

// Move to different file
struct RespondToConnectRequestRow: View {
    var activity: Activity
    @EnvironmentObject var activityViewModel: ActivityViewModel
    var body: some View {
        
        HStack {
          // Ignore Button (todo: put in own file)
          Button( action: { activityViewModel.deleteConnectRequest(fromUserId: activity.userId) }) {
            Text("Ignore")
                .fontWeight(.bold).foregroundColor(Color.black)
                .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color.lightGray)
          
          // Accept Button (todo: put in own file)
          Button(action: { activityViewModel.acceptConnectRequest(fromUserId: activity.userId) }) {
              Text("Accept")
                  .fontWeight(.bold).foregroundColor(Color.white)
                  .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color(.systemTeal))
        }
        .padding(.top, 5)
    }
}
