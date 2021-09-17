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
    @Published var showOpenPosts = true
    @Published var emptyState = false
  
    var openListener: ListenerRegistration!
    var closedListener: ListenerRegistration!
  

    
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
        userId: userId,
        onEmpty: {
          self.isLoading = false
        },
        onSuccess: { (posts) in
          if self.openPosts.isEmpty {
            self.openPosts = posts
            self.isLoading = false
          }
      }, newPost: { (post) in
          if !self.openPosts.isEmpty {
              self.openPosts.insert(post, at: 0)
          }
      }, modifiedPost: {(post) in
        if !self.openPosts.isEmpty {
          if let index = self.openPosts.firstIndex(where: {$0.id == post.id}) {
            self.openPosts[index] = post

          }
        }
      },
        deletePost: { (post) in

          if !self.openPosts.isEmpty {
              for (index, p) in self.openPosts.enumerated() {
                  if p.postId == post.postId {
                    self.openPosts.remove(at: index)
                  }
              }
          }
      }) { (listener) in
          self.openListener = listener
      }
      
    // these calls should be called elsewhere
      updateIsConnected(userId: userId)
      updateConnectionsCount(userId: userId)
      self.loadClosedPosts()
    }
    
    func loadClosedPosts() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.isLoading = true
    
      Api.Post.loadClosedPosts(
        userId: userId,
        onEmpty: {
          self.isLoading = false
        },
        onSuccess: { (posts) in

          if self.closedPosts.isEmpty {
              self.closedPosts = posts
              self.isLoading = false
          }
      }, newPost: { (post) in
          if !self.closedPosts.isEmpty {
            if !self.closedPosts.contains(post) {
              self.closedPosts.insert(post, at: 0)
            }
          }
      }, modifiedPost: { (post) in
            if !self.closedPosts.isEmpty {
              if let index = self.closedPosts.firstIndex(where: {$0.id == post.id}) {
                self.closedPosts[index] = post
              }
            }
      }, deletePost: { (post) in

          if !self.closedPosts.isEmpty {
              for (index, p) in self.closedPosts.enumerated() {
                  if p.postId == post.postId {
                    self.closedPosts.remove(at: index)
                  }
              }
          }
      }) { (listener) in
        self.closedListener = listener
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
