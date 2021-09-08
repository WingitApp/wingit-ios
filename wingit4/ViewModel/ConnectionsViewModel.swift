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
    
    @Published var isLoading = true
    @Published var users: [User] = []
    @Published var connectionsCount = 0
    
    func loadConnections(userId: String?) {
        guard let userId = userId else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading.toggle()
            self.users = users
            self.connectionsCount = users.count
        }
    }
    
    func sendConnectRequest(userId: String) {
        let currentUserId = Auth.auth().currentUser!.uid
        
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
    
    
    func disconnect(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        let currentUserId = Auth.auth().currentUser!.uid
        
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
               connectionsCount_onSuccess(doc.count)
            }
        }
    }
}

