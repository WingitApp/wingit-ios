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
    
    @Published var isConnected = false
    @Published var sentPendingRequest = false
    @Published var connectionsCountState = 0
    
    func loadConnections(userId: String?) {
        guard let userId = userId else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.users = users.sorted(by: {
              $0.firstName! < $1.firstName!
            })
            self.connectionsCount = users.count
          if self.isLoading {
            self.isLoading.toggle()
          }
        }
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
        
       let activityId = Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let activityObject = Activity(activityId: activityId, type: "connectRequest", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", date: Date().timeIntervalSince1970)
       guard let activityDict = try? activityObject.toDictionary() else { return }

       Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
        
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
}

