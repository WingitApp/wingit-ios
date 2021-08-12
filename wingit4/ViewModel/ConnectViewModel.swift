//
//  ConnectViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/12/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ConnectViewModel: ObservableObject {
    
    func sendConnectRequest(userId: String) {
        
        Ref.FIRESTORE_COLLECTION_CONNECTION_REQUEST_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).setData([:]) { (error) in
            if error == nil {
                self.updateFollowCount(userId: userId, followingCount_onSuccess: followingCount_onSuccess, followersCount_onSuccess: followersCount_onSuccess)
            }
        }
        
       let activityId = Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document().documentID
        let activityObject = Activity(activityId: activityId, type: "follow", username: Auth.auth().currentUser!.displayName!, userId: Auth.auth().currentUser!.uid, userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString, postId: "", mediaUrl: "", comment: "", gemComment: "", date: Date().timeIntervalSince1970)
       guard let activityDict = try? activityObject.toDictionary() else { return }

       Ref.FIRESTORE_COLLECTION_ACTIVITY.document(userId).collection("feedItems").document(activityId).setData(activityDict)
        
    }
    
    
    func disconnect(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void) {
        
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
                self.updateConnectionsCount(userId: userId, connectionsCount_onSuccess: connectionsCount_onSuccess)
            }
        }
    }
    
    func updateConnectionsCount(userId: String, connectionsCount_onSuccess: @escaping(_ connectionsCount: Int) -> Void ) {
        Ref.FIRESTORE_COLLECTION_CONNECTIONS(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                connectionsCount_onSuccess(doc.count)
            }
        }
    }
    
}

