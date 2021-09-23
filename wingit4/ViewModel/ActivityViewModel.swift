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


class ActivityViewModel: ObservableObject {
    
    @Published var activityArray: [Activity] = []
    var listener: ListenerRegistration!
    
    @Published var isLoading = true

    
    func loadActivities() {
        self.activityArray = []
        isLoading = true
        
        Api.Activity.loadActivities(
          onEmpty: {
            self.isLoading = false
          },
          onSuccess: { (activityArray) in
            if self.activityArray.isEmpty {
                self.activityArray = activityArray
                self.isLoading = false
            }
          }, newActivity: { (activity) in
              if !self.activityArray.isEmpty {
                if !self.activityArray.contains(activity) {
                  self.activityArray.insert(activity, at: 0)
                  self.isLoading = false
                }
              }
          }, deleteActivity: { (activity) in
              if !self.activityArray.isEmpty {
                  for (index, a) in self.activityArray.enumerated() {
                      if a.activityId == activity.activityId {
                          self.activityArray.remove(at: index)
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
        let activityId = Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
                 let activityObject = Activity(activityId: activityId, type: "connectRequestAccepted", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
                guard let activityDict = try? activityObject.toDictionary() else { return }

                Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
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

