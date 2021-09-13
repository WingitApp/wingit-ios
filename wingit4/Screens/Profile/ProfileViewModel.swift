//
//  ProfileViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var openPosts: [Post] = []
    @Published var closedPosts: [Post] = []
    var user: User!

    @Published var isLoading = false
    @Published var userBlocked = false
    @Published var showImagePicker: Bool = false
    @Published var connectionsCountState = 0
  
    @Published var isUpdatePicSheetOpen: Bool = false
    
    @Published var isConnected = false
  
    var listener: ListenerRegistration!

    
    func updateIsConnected(userId: String) {
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: Auth.auth().currentUser!.uid).document(userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
    }
    
    func loadUserPosts() {
      guard let userId = Auth.auth().currentUser?.uid else { return }
      
      self.openPosts = []
      isLoading = true
      
      Api.Post.loadOpenPosts(
        onSuccess: { (posts) in
          if self.openPosts.isEmpty {
              self.openPosts = posts
            self.isLoading = false
          }
      }, newPost: { (post) in
          if !self.openPosts.isEmpty {
              self.openPosts.insert(post, at: 0)
          }
      }, deletePost: { (post) in
          if !self.openPosts.isEmpty {
              for (index, p) in self.openPosts.enumerated() {
                  if p.postId == post.postId {
                      self.openPosts.remove(at: index)

                  }
              }
          }
      }) { (listener) in
          self.listener = listener
      }
      
    // these calls should be called elsewhere
      updateIsConnected(userId: userId)
      updateConnectionsCount(userId: userId)
      self.loadClosedPosts()
    }
    
    func loadClosedPosts() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.isLoading = true
        Api.Post.loadClosedPosts(userId: userId) { (posts) in
            self.isLoading = false
            self.closedPosts = posts
        }
    }
    
    func updateConnectionsCount(userId: String) {
        Ref.FS_COLLECTION_CONNECTIONS_FOR_USER(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                self.connectionsCountState = doc.count
            }
        }
    }
}
