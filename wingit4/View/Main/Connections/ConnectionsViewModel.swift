//
//  ConnectionsViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//
//
import SwiftUI
import UIKit
import FirebaseAuth
import Amplitude

class ConnectionsViewModel : ObservableObject {
    
    @Published var isLoading = false
    @Published var users: [User] = []
    @Published var connectionsCount = 0
    
    func loadConnections(userId: String) {
        isLoading = true
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading = false
            self.users = users
            self.connectionsCount = users.count
            setUserProperty(property: .connections, value: users.count)
        }
    }
    
    func sendConnectRequest(userId: String) {
        let currentUserId = Auth.auth().currentUser!.uid
        logToAmplitude(event: .sendConnectRequest, properties: [.toUser : userId])
        
        Ref.FIRESTORE_DOC_CONNECT_REQUEST_SENT(sentByUserId: currentUserId, receivedByUserId: userId).setData([:]) { (error) in
            if error == nil {
                
            }
        }
        
        Ref.FIRESTORE_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: userId, sentFromUserId: currentUserId).setData([:]) { (error) in
            if error == nil {
                
            }
        }
        
       let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let activityObject = Activity(activityId: activityId, type: "connectRequest", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
       guard let activityDict = try? activityObject.toDictionary() else { return }

       Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
        
    }
    
    
    func disconnect(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        let currentUserId = Auth.auth().currentUser!.uid
        
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: currentUserId).document(userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
        
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).document(currentUserId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                addToUserProperty(property: .connections, value: -1)
                doc.reference.delete()
                self.updateConnectionsCount(userId: userId, connectionsCount_onSuccess: connectionsCount_onSuccess)
            }
        }
    }
    
    func updateConnectionsCount(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
               connectionsCount_onSuccess(doc.count)
            }
        }
    }
    
    func acceptConnectRequest(fromUserId: String) {
        logToAmplitude(event: .acceptConnectRequest, properties: [.fromUser: fromUserId])
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
                        addToUserProperty(property: .connections, value: 1)
                        self.sendConnectRequestAcknowledgement(userId: userId)
                    }
                }
            }
        }
    }
    
    func sendConnectRequestAcknowledgement(userId: String) {
        let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
         let activityObject = Activity(activityId: activityId, type: "connectRequestAccepted", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
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
        logToAmplitude(event: .ignoreConnectRequest, properties: [.fromUser: fromUserId])
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

