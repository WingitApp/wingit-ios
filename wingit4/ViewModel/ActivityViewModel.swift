//
//  ActivityViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Foundation
import SwiftUI
import Firebase


class ActivityViewModel: ObservableObject {
    
    @Published var activityArray: [Activity] = []
    var listener: ListenerRegistration!

    
    func loadActivities() {
        self.activityArray = []
        
        Api.Activity.loadActivities(onSuccess: { (activityArray) in
            if self.activityArray.isEmpty {
                self.activityArray = activityArray
            }
        }, newActivity: { (activity) in
            if !self.activityArray.isEmpty {
                self.activityArray.insert(activity, at: 0)
            }
        }, deleteActivity: { (activity) in
            if !self.activityArray.isEmpty {
                for (index, a) in self.activityArray.enumerated() {
                    if a.activityId == activity.activityId {
                        self.activityArray.remove(at: index)
                    }
                }
            }
        }) { (listener) in
            self.listener = listener
        }
    }
    
    func acceptConnectRequest(fromUserId: String) {
        deleteConnectRequest(fromUserId: fromUserId)
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(Auth.auth().currentUser!.uid).collection("feedItems").whereField("type", isEqualTo: "connectRequest").whereField("userId", isEqualTo: fromUserId).getDocuments { (snapshot, error) in
               if let doc = snapshot?.documents {
                   if let data = doc.first, data.exists {
                        // Delete Connect Request from Feed
                        data.reference.delete()
                        self.addConnectionToUser(userId: fromUserId)
                   }
               }
           }
    }
    
    // Adds a bi-directional connection
    func addConnectionToUser(userId: String) {
        Ref.FIRESTORE_DOC_CONNECTION_BETWEEN_USERS(user1Id: Auth.auth().currentUser!.uid, user2Id: userId).setData([:]) { (error) in
            // Add the reverse connection if the first direction succeeds
            if error == nil {
                Ref.FIRESTORE_DOC_CONNECTION_BETWEEN_USERS(user1Id: userId, user2Id: Auth.auth().currentUser!.uid).setData([:]) { (error) in
                    if error == nil {
                        self.sendConnectRequestAcknowledgement(userId: userId)
                    }
                }
            }
        }
    }
    
    func sendConnectRequestAcknowledgement(userId: String) {
        let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
         let activityObject = Activity(activityId: activityId, type: "connectRequestAccepted", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", gemComment: "", date: Date().timeIntervalSince1970)
        guard let activityDict = try? activityObject.toDictionary() else { return }

        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
    }
    
    func deleteConnectRequest(fromUserId: String) {
        // Delete the request from the current user's inbox
        Ref.FIRESTORE_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: Auth.auth().currentUser!.uid, sentFromUserId: fromUserId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
        
        // Delete the request from the sender's sent box
        Ref.FIRESTORE_DOC_CONNECT_REQUEST_SENT(sentByUserId: fromUserId, receivedByUserId: Auth.auth().currentUser!.uid).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
    
    func ignoreConnectRequest(fromUserId: String) {
        deleteConnectRequest(fromUserId: fromUserId)
        
        // Delete the request from notification's feed
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(Auth.auth().currentUser!.uid).collection("feedItems").whereField("type", isEqualTo: "connectRequest").whereField("userId", isEqualTo: fromUserId).getDocuments { (snapshot, error) in
               if let doc = snapshot?.documents {
                   if let data = doc.first, data.exists {
                       data.reference.delete()
                   }
               }
           }
    }
}

