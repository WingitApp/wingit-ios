//
//  ActivityViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Amplitude
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift


class NotificationViewModel: ObservableObject {
    @EnvironmentObject var mainViewModel: MainViewModel
    @AppStorage("notificationsLastSeenAt") var notificationsLastSeenAt: Double = 1633885030
    @Published var notificationsArray: [Notification] = []
    var listener: ListenerRegistration!
    
    @Published var isLoading = true
    @Published var unreadNotifications: Int = 0
    
    // Variables to leep track of what option has been tapped on and when to navigate to new view
    @Published var selectedNotificationType = NotificationLinkType.userProfile
    @Published var post: Post?
    @Published var isNavigationLinkActive: Bool = false
    @Published var userProfileId: String?
   
    func updateOpenedAt(notificationId: String?) {
        guard let notificationId = notificationId, let userId = Auth.auth().currentUser?.uid else { return }
        
        Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems") .document(notificationId).setData(["openedAt": FieldValue.serverTimestamp()], merge: true)
    }
  
  func updateNotificationsLastSeenAt() {
    unreadNotifications = 0
    notificationsLastSeenAt = Date().timeIntervalSince1970
    
    guard let userId = Auth.auth().currentUser?.uid else { return }
    
    Ref.FS_COLLECTION_USERS.document(userId).setData(["notificationsLastSeenAt": FieldValue.serverTimestamp()], merge: true)
  }
    
    func loadNotifications() {
        self.notificationsArray = []
        isLoading = true
        
        Api.Notifications.loadNotifications(
          onEmpty: {
            self.isLoading = false
          }, newNotification: { (notification) in
            if !self.notificationsArray.contains(notification) {
              self.notificationsArray.insert(notification, at: 0)
              self.isLoading = false
              if (notification.date > self.notificationsLastSeenAt) {
                self.unreadNotifications += 1
              }
            }
          }, deleteNotification: { (notification) in
              if !self.notificationsArray.isEmpty {
                  for (index, n) in self.notificationsArray.enumerated() {
                      if n.activityId == notification.activityId {
                          self.notificationsArray.remove(at: index)
                          self.isLoading = false
                      }
                  }
              }
          }) { (listener) in
              self.listener = listener
          }
    }
  
  func openNotification(notificationId: String?, correspondingUserId: String?) {
      notificationsArray.forEach { notification in
        if (notification.activityId == notificationId) {
          switch(ViewRouter.shared.currentScreen) {
            case .askDetail:
              selectedNotificationType = NotificationLinkType.askDetail
              post = notification.post
              isNavigationLinkActive = true
            case .userProfile:
              selectedNotificationType = NotificationLinkType.userProfile
              userProfileId = correspondingUserId
              isNavigationLinkActive = true
            case .referral:
              mainViewModel.setTab(tab: .referrals)
            default:
              if let correspondingUserId = correspondingUserId {
                selectedNotificationType = NotificationLinkType.userProfile
                userProfileId = correspondingUserId
                isNavigationLinkActive = true
              }
          }
          updateOpenedAt(notificationId: notificationId)
        }
      }
    }
    
    func acceptConnectRequest(fromUserId: String?) {
        guard let fromUserId = fromUserId else { return }
        deleteConnectRequest(fromUserId: fromUserId)
        addConnectionToUser(userId: fromUserId)
        sendConnectAcceptedAcknowledgement(userId: fromUserId)
    }
    
    // Adds a bi-directional connection
    func addConnectionToUser(userId: String) {
        Ref.FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: Auth.auth().currentUser!.uid, user2Id: userId).setData([:])
        Ref.FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: userId, user2Id: Auth.auth().currentUser!.uid).setData([:])
        addToUserProperty(property: .connections, value: 1)
    }
    
    func sendConnectAcceptedAcknowledgement(userId: String) {
        let activityId = Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let notificationObject = Notification(activityId: activityId, comment: "", date: Date().timeIntervalSince1970, mediaUrl: "", postId: "", type: "connectRequestAccepted", userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, userId: Auth.auth().currentUser!.uid, username: Auth.auth().currentUser!.displayName!)
       guard let notificationDict = try? notificationObject.toDictionary() else { return }

       Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(notificationDict)
    }
    
    func deleteConnectRequest(fromUserId: String?) {
        guard let fromUserId = fromUserId else { return }
        // Delete the request from the current user's inbox
        Ref.FS_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: Auth.auth().currentUser!.uid, sentFromUserId: fromUserId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
        
        // Delete the request from the sender's sent box
        Ref.FS_DOC_CONNECT_REQUEST_SENT(sentByUserId: fromUserId, receivedByUserId: Auth.auth().currentUser!.uid).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
        
        // Delete the request from notification feeds
        Ref.FS_COLLECTION_ACTIVITY.document(Auth.auth().currentUser!.uid).collection("feedItems").whereField("type", isEqualTo: "connectRequest").whereField("userId", isEqualTo: fromUserId).getDocuments { (snapshot, error) in
               if let docs = snapshot?.documents {
                    for doc in docs {
                        doc.reference.delete()
                    }
               }
           }
    }
}

