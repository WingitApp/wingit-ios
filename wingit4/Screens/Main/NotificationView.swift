//
//  NotificationView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
import SwiftUI

struct NotificationView: View {
    
  @EnvironmentObject var notificationViewModel: NotificationViewModel
  @EnvironmentObject var mainViewModel: MainViewModel
    
    
  func sortNotifications() -> Void {
    self.notificationViewModel.notificationsArray.sort { $0.date > $1.date }
  }
    
    var body: some View {
       
        NavigationView {

            if notificationViewModel.notificationsArray.isEmpty && !notificationViewModel.isLoading {
                NotificationEmptyState(
                  title: "No notifications!",
                  description: "Start interacting with friends to get started.",
                  iconName: "bell",
                  iconColor: Color("Color"),
                  function: nil
                )
            } else {
              ScrollView(showsIndicators: false) {
                if notificationViewModel.isLoading {
                  ReferralPlaceholder(type: "accepted")
                  ReferralPlaceholder(type: "accepted")
                  ReferralPlaceholder(type: "accepted")
                }
                
              LazyVStack(alignment: .leading) {
                if !notificationViewModel.notificationsArray.isEmpty {
                    ForEach(self.notificationViewModel.notificationsArray, id: \.activityId) { notification in
                      HStack(alignment: .top) {
                            if notification.type == "comment" {
        
                                    CommentNotification(notification: notification)
                                    .buttonStyle(PlainButtonStyle())
                            }else if notification.type == "connectRequest" {
                                    CommentNotificationRow(
                                      notification: notification,
                                      notificationViewModel: self.notificationViewModel
                                    )

                            } else if notification.type == "referred" {
                                NotificationReferralEntry(
                                  notification: notification
                                )
                            } else {
                              NavigationLink (destination: UserProfileView(userId: notification.userId, user: nil)){

                                 NotificationUserAvatar(
                                  imageUrl: notification.userAvatar,
                                  type: notification.type
                                 )
                                  .padding(.trailing, 10)

                              VStack(alignment: .leading) {
                                HStack(alignment: .center, spacing: 5) {
                                  Text(notification.username).bold() + Text(" ") + Text(notification.typeDescription ?? "")
                                }
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)

                                Spacer()
                                Text(timeAgoSinceDate(Date(timeIntervalSince1970: notification.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                              }

                            }.buttonStyle(PlainButtonStyle())

                          }


                        }
                        .padding(15)
                        Divider()
                    }
                }
                  
           
            }
              .navigationBarTitle(Text("Notifications"), displayMode: .inline)
              .environmentObject(mainViewModel)
            }
        }
        } .onAppear {
            sortNotifications()
        }
    }
}

struct CommentNotificationRow: View {
    var notification: Notification
    var notificationViewModel: NotificationViewModel
    var body: some View {

        HStack(alignment: .top) {
          NotificationUserAvatar(
           imageUrl: notification.userAvatar,
           type: notification.type
          )
           .padding(.trailing, 10)
            .padding(.trailing, 10)

          HStack{
              VStack(alignment: .leading) {
                  Text(notification.username).bold() + Text(" ") + Text(notification.typeDescription ?? "")
                
                VStack(alignment: .leading) {
                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: notification.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
                    Spacer()
                      RespondToConnectRequestRow(notification: notification)
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
    var notification: Notification
    @EnvironmentObject var activityViewModel: NotificationViewModel
    var body: some View {
        
        HStack {
          // Ignore Button (todo: put in own file)
          Button( action: { activityViewModel.deleteConnectRequest(fromUserId: notification.userId) }) {
            Text("Ignore")
                .fontWeight(.bold).foregroundColor(Color.black)
                .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color.lightGray)

          // Accept Button (todo: put in own file)
          Button(action: {
                    logToAmplitude(event: .acceptConnectRequest, properties: [.userId: notification.userId])
                    activityViewModel.acceptConnectRequest(fromUserId: notification.userId) }) {
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


