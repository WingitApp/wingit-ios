//
//  UserProfileViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//


import Foundation
import SwiftUI
import FirebaseAuth

class UserProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var doneposts: [DonePost] = []
    
    @Published var isLoading = false
    @Published var userBlocked = false
    @Published var connectionsCountState = 0
    @Published var showImagePicker: Bool = false

    var splitted: [[Post]] = []
    
    @Published var isConnected = false
    @Published var sentPendingRequest = false
    
    func updateIsConnected(userId: String) {
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: Auth.auth().currentUser!.uid).document(userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
    }
    
    func updateSentPendingRequest(userId: String) {
        Ref.FS_DOC_CONNECT_REQUEST_SENT(sentByUserId: Auth.auth().currentUser!.uid, receivedByUserId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.sentPendingRequest = true
            } else {
                self.sentPendingRequest = false
            }
        }
    }
    
    func loadUserPosts(userId: String) {
      if !self.isLoading {
        self.isLoading.toggle()

        Api.User.loadPosts(userId: userId) { (posts) in
            self.posts = posts
            self.isLoading.toggle()
        }
        updateIsConnected(userId: userId)
        updateSentPendingRequest(userId: userId)
        updateConnectionsCount(userId: userId)
        self.loadDonePosts(userId: userId)
      }
    }
    
    func loadDonePosts(userId: String) {
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
    
    func updateConnections(userId: String) {
        
    }
    
    func updateConnectionsCount(userId: String) {
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                self.connectionsCountState = doc.count
            }
        }
    }
    
    func checkUserBlocked(userId: String, postOwnerId: String?){
        guard let postOwnerId = postOwnerId else { return }
        Ref.FS_DOC_BLOCKED_USERID(userId: userId).collection("userBlocked").document(postOwnerId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                return
            }; Ref.FS_DOC_BLOCKED_USERID(userId: userId).collection("userBlockedBy").document(postOwnerId).getDocument { (document, error) in
                if let doc = document, doc.exists {
                    self.userBlocked = true
                    return
                } else {
                self.loadUserPosts(userId: postOwnerId)
              //  self.loadDonePosts(userId: postOwnerId)
            }
        }
    }
}
}
