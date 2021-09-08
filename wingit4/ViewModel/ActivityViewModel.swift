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
    
    @Published var activityArray: [ActivityEvent] = []
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
                    if a.id == activity.id {
                        self.activityArray.remove(at: index)
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
    }
    
    func sendConnectAcceptedAcknowledgement(userId: String) {
        let currentUser = Auth.auth().currentUser
        let activityEvent = ActivityEvent(id: nil, createdAt: nil, connectionId: currentUser?.uid, connectionName: currentUser?.displayName, mediaUrl: currentUser?.photoURL?.absoluteString, text: "", type: .connectRequestAccepted, userId: userId)
        do {
            let _ = try Ref.FS_COLLECTION_ACTIVITY_EVENTS_FOR_USER(userId: userId).addDocument(from: activityEvent)
        } catch {
            print(error)
        }
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
    }
    
    func ignoreConnectRequest(fromUserId: String?) {
        guard let fromUserId = fromUserId else { return }
        deleteConnectRequest(fromUserId: fromUserId)
        
        // Delete the request from notification's feed
        Ref.FS_COLLECTION_ACTIVITY.document(Auth.auth().currentUser!.uid).collection("feedItems").whereField("type", isEqualTo: "connectRequest").whereField("userId", isEqualTo: fromUserId).getDocuments { (snapshot, error) in
               if let doc = snapshot?.documents {
                   if let data = doc.first, data.exists {
                       data.reference.delete()
                   }
               }
           }
    }
}

