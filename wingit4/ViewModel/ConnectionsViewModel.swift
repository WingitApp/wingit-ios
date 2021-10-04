//
//  ConnectionsViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//
//

import Amplitude
import FirebaseAuth
import SwiftUI
import UIKit

class ConnectionsViewModel : ObservableObject {
    
    @Published var isLoading = true
    @Published var users: [User] = []
    @Published var connectionsCount = 0
    @Published var isConnectionsSheetOpen: Bool = false
    @Published var selectedUsers: [String?] = []
    var allConnectRecipientIds: [String?] = []
    
    func loadConnections(userId: String?) {
        guard let userId = userId else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(
            userId: userId,
            onSuccess: { (users) in
                self.users = users.sorted(by: {
                  $0.firstName! < $1.firstName!
                })
                self.connectionsCount = users.count
                self.isLoading.toggle()
            },
            onEmpty: {
              self.isLoading = false
            }
        )
    }
    
    func handleUserSelect(userId: String?) {
        guard let userId = userId else { return }
        if selectedUsers.contains(userId) {
            self.selectedUsers.removeAll(where: { $0 == userId })
           // self.sendConnectRequest(userId: userId)
        } else {
            self.selectedUsers.append(userId)
        }
    }
    
    func sendConnectRequest(userId: String?) {
        guard let userId = userId, let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Ref.FS_DOC_CONNECT_REQUEST_SENT(sentByUserId: currentUserId, receivedByUserId: userId).setData([:]) { (error) in
            if error == nil {
                
            }
        }
        
        Ref.FS_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: userId, sentFromUserId: currentUserId).setData([:]) { (error) in
            if error == nil {
                
            }
        }
        
        let userActivity = UserActivity(activityType: .sendConnectRequest, correspondingUserId: userId, currentUserId: currentUserId)
        Api.UserActivity.logActivity(activity: userActivity)
        
        let activityId = Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let notification = Notification(activityId: activityId, comment: "", date: Date().timeIntervalSince1970, mediaUrl: "", postId: "", type: "connectRequest", userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, userId: Auth.auth().currentUser!.uid, username: Auth.auth().currentUser!.displayName!)
        
        do {
            try Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(from: notification)
        } catch {
            print(error)
        }
    }
    
    
    func disconnect(userId: String?, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        guard let userId = userId, let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: currentUserId).document(userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
        
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).document(currentUserId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
                self.updateConnectionsCount(userId: userId, connectionsCount_onSuccess: connectionsCount_onSuccess)
            }
        }
    }
    
    func updateConnectionsCount(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                setUserProperty(property: .connections, value: doc.count)
                connectionsCount_onSuccess(doc.count)
            }
        }
    }
    
    func acceptConnectRequest(userId: String) {
        deleteConnectRequest(userId: userId)
        addConnectionToUser(userId: userId)
    }
    
    func addConnectionToUser(userId: String) {
        Ref.FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: Auth.auth().currentUser!.uid, user2Id: userId).setData([:])
        Ref.FS_DOC_CONNECTION_BETWEEN_USERS(user1Id: userId, user2Id: Auth.auth().currentUser!.uid).setData([:])
        addToUserProperty(property: .connections, value: 1)
    }
    
    func deleteConnectRequest(userId: String?) {
        guard let userId = userId else { return }
        // Delete the request from the current user's inbox
        Ref.FS_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: Auth.auth().currentUser!.uid, sentFromUserId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
}

