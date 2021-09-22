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
            if activityViewModel.activityArray.count == 0 && !activityViewModel.isLoading {
                EmptyState(
                  title: "No notifications!",
                  description: "Start interacting with friends to get the party started.",
                  iconName: "mustache",
                  iconColor: Color("Color"),
                  function: nil
                )
            } else {
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
                                    CommentActivityRow(
                                      activity: activity,
                                      activityViewModel: self.activityViewModel
                                    )
                            } else if activity.type == "referred" {
                                NotificationReferralEntry(activity: activity)
                            } else {
                              NavigationLink (destination: UserProfileView(userId: activity.userId, user: nil)){

                                 NotificationUserAvatar(
                                  imageUrl: activity.userAvatar,
                                  type: activity.type
                                 )
                                  .padding(.trailing, 10)

                              VStack(alignment: .leading) {
                                HStack(alignment: .center, spacing: 5) {
                                  Text(activity.username).bold() + Text(" ") + Text(activity.typeDescription)
                                }
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)

                                Spacer()
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                              }

                                
                               
                            }                          .buttonStyle(PlainButtonStyle())

                          }


                        }
                        .padding(
                          EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0)
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
}

struct CommentActivityRow: View {
    var activity: Activity
    var activityViewModel: ActivityViewModel
    var body: some View {

        HStack(alignment: .top) {
          NotificationUserAvatar(
           imageUrl: activity.userAvatar,
           type: activity.type
          )
           .padding(.trailing, 10)
            .padding(.trailing, 10)

          HStack{
              VStack(alignment: .leading) {
                  Text(activity.username).bold() + Text(" ") + Text(activity.typeDescription)
                
                VStack(alignment: .leading) {
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: activity.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    Spacer()
                      RespondToConnectRequestRow(activity: activity)
                  }
                  .padding(.top, 3)
              }
              .font(.subheadline)
              .fixedSize(horizontal: false, vertical: true)
          }
          .frame(maxWidth: UIScreen.main.bounds.width - 40)
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
          Button(action: {
                    logToAmplitude(event: .acceptConnectRequest, properties: [.userId: activity.userId])
                    activityViewModel.acceptConnectRequest(fromUserId: activity.userId) }) {
              Text("Accept")
                  .fontWeight(.bold).foregroundColor(Color.white)
                  .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color.wingitBlue)
        }
        .padding(.top, 5)
    }
}


