//
//  ProfileViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var gemposts: [gemPost] = []
    @Published var doneposts: [DonePost] = []
    
    @Published var isLoading = false
    @Published var userBlocked = true
    @Published var connectionsCountState = 0
    @Published var showImagePicker: Bool = false
   // var user: User!

    var splitted: [[Post]] = []
    var gemsplit: [[gemPost]] = []
    
    @Published var isConnected = false
    @Published var hasPendingRequest = false
    
    func updateIsConnected(userId: String) {
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: Auth.auth().currentUser!.uid).document(userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
    }
    
    func updateHasPendingRequest(userId: String) {
        Ref.FIRESTORE_DOC_CONNECT_REQUEST_SENT(sentByUserId: Auth.auth().currentUser!.uid, receivedByUserId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.hasPendingRequest = true
            } else {
                self.hasPendingRequest = false
            }
        }
    }
    
    func loadUserPosts(userId: String) {
        isLoading = true
        Api.User.loadPosts(userId: userId) { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
        updateIsConnected(userId: userId)
        updateHasPendingRequest(userId: userId)
        updateConnectionsCount(userId: userId)
        self.loadGemPosts(userId: userId)
        self.loadDonePosts(userId: userId)
    }
    
    func loadGemPosts(userId: String) {
        isLoading = true
        Api.User.loadGemPosts(userId: userId) { (gemposts) in
            self.isLoading = false
            self.gemposts = gemposts
            self.gemsplit = self.gemposts.splited(into: 3)
        }
    }
    
    func loadDonePosts(userId: String) {
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
    
    func updateConnectionsCount(userId: String) {
        Ref.FIRESTORE_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                self.connectionsCountState = doc.count
            }
        }
    }
    
    func checkUserBlocked(userId: String, postOwnerId: String){
        Ref.FIRESTORE_COLLECTION_BLOCKED_USERID(userId: userId).collection("userBlocked").document(postOwnerId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                return
            }; Ref.FIRESTORE_COLLECTION_BLOCKED_USERID(userId: userId).collection("userBlockedBy").document(postOwnerId).getDocument { (document, error) in
                if let doc = document, doc.exists {
                    return
                } else {
                self.loadUserPosts(userId: postOwnerId)
                self.loadGemPosts(userId: postOwnerId)
              //  self.loadDonePosts(userId: postOwnerId)
                self.userBlocked = false
            }
        }
    }
}
}
