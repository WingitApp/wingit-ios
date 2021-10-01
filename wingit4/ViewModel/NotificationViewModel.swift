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
    
    @Published var notificationsArray: [Notification] = []
    var listener: ListenerRegistration!
    
    @Published var isLoading = true
//    @Published var destination: AskDetailView?
   
    func updateWasOpened(notificationId: String){
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Ref.FS_COLLECTION_ACTIVITY .document(userId).collection("feedItems") .document(notificationId).setData(["wasOpened": true], merge: true)
    
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
        // add connect request accepted UserActivity
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

