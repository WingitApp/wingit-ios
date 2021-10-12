//
//  NotificationView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
import FirebaseFirestore
import Foundation
import SwiftUI

struct NotificationView: View {
  @ObservedObject var viewRouter = ViewRouter.shared
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var notificationViewModel: NotificationViewModel
  @EnvironmentObject var mainViewModel: MainViewModel
  @StateObject var askCardViewModel = AskCardViewModel()
  @StateObject var askMenuViewModel = AskMenuViewModel()
  @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
  // Comment
  @StateObject var commentViewModel = CommentViewModel()
  @StateObject var referViewModel = ReferViewModel()
  @StateObject var commentInputViewModel = CommentInputViewModel()
  
  func openPushNotification() {
    self.notificationViewModel.openNotification(notificationId: ViewRouter.shared.activityId, correspondingUserId: ViewRouter.shared.userId)
  }
    
  func sortNotifications() -> Void {
    self.notificationViewModel.notificationsArray.sort { $0.date > $1.date }
  }
    func cleanState() -> Void {
        notificationViewModel.isNavigationLinkActive = false
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
                  NavigationLink("",
                      destination: NotificationViewNavigationOption(
                          linkType: $notificationViewModel.selectedNotificationType,
                          post: $notificationViewModel.post,
                          userProfileId: $notificationViewModel.userProfileId)
                             .environmentObject(askCardViewModel)
                             .environmentObject(askMenuViewModel)
                             .environmentObject(askDoneToggleViewModel)
                             .environmentObject(commentViewModel)
                             .environmentObject(commentInputViewModel),
                      isActive: $notificationViewModel.isNavigationLinkActive)
                  .onReceive(viewRouter.$currentScreen) { nav in
                    if nav != nil {
                      openPushNotification()
                    }
                  }
                if notificationViewModel.isLoading {
                  ReferralPlaceholder(type: "accepted")
                  ReferralPlaceholder(type: "accepted")
                  ReferralPlaceholder(type: "accepted")
                }
                if !notificationViewModel.notificationsArray.isEmpty {
                  LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach($notificationViewModel.notificationsArray, id: \.activityId) { $notification in
                            if notification.type == "comment" {
                                CommentNotification(notification: $notification)
                            } else if notification.type == "connectRequest" {
                                ConnectRequestNotification(
                                  notification: notification,
                                  notificationViewModel: self.notificationViewModel
                                )
                                .if(notification.openedAt == nil) { view in
                                    view.background(Color.notificationBackground)
                                }
                            } else if notification.type == "referred" {
                                NotificationReferralEntry(
                                  notification: $notification
                                )
                                .if(notification.openedAt == nil) { view in
                                    view.background(Color.notificationBackground)
                                }
                            } else {
                                HStack(alignment: .top) {
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
                                    Spacer()
                            }
                            .onTapGesture {
                                notification.openedAt = Timestamp(date: Date())
                                notificationViewModel.updateOpenedAt(notificationId: notification.activityId)
                                notificationViewModel.userProfileId = notification.userId
                                notificationViewModel.selectedNotificationType = NotificationLinkType.userProfile
                                notificationViewModel.isNavigationLinkActive = true
                            }
                            .padding()
                            .buttonStyle(PlainButtonStyle())
                            .if(notification.openedAt == nil) { view in
                                view.background(Color.notificationBackground)
                            }
                          
                          }
                      
                    }
                  }
                  .navigationBarTitle(Text("Notifications"), displayMode: .inline)
                  .navigationBarHidden(false) // needed for ipad pro
                  .environmentObject(mainViewModel)
                }

            }
        }
        }
        .switchStyle(if: UIDevice.current.userInterfaceIdiom == .phone)
        .onAppear {
          if session.isLoggedIn {
            logToAmplitude(event: .viewNotifications)
            notificationViewModel.updateNotificationsLastSeenAt()
          }
            sortNotifications()
            cleanState()
        }
    }
}

struct ConnectRequestNotification: View {
    var notification: Notification
    var notificationViewModel: NotificationViewModel

    var body: some View {
        HStack(alignment: .top) {
        
        NavigationLink(destination: ProfileView(userId: notification.userId, user: nil)) {
              NotificationUserAvatar(
               imageUrl: notification.userAvatar,
               type: notification.type
              )
               .padding(.trailing, 10)
               .padding(.trailing, 10)
            }
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
//            Spacer()
        }.padding()

    }
}

// Move to different file
struct RespondToConnectRequestRow: View {
    var notification: Notification
    @EnvironmentObject var notificationViewModel: NotificationViewModel
    var body: some View {
        
        HStack {
          // Ignore Button (todo: put in own file)
          Button( action: {
              notificationViewModel.deleteConnectRequest(fromUserId: notification.userId)
              logToAmplitude(event: .declineConnectRequest, properties: [.userId: notification.userId])
          }) {
            Text("Ignore")
                .fontWeight(.bold).foregroundColor(Color.black)
                .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color.lightGray)

          // Accept Button (todo: put in own file)
          Button(action: {
                    logToAmplitude(event: .acceptConnectRequest, properties: [.userId: notification.userId])
                    notificationViewModel.acceptConnectRequest(fromUserId: notification.userId) }) {
              Text("Accept")
                  .fontWeight(.bold).foregroundColor(Color.white)
                  .font(.system(size: 14))
          }
          .modifier(ConnectionNotifButtonStyle())
          .background(Color.wingitBlue)
        }
        
    }
}


