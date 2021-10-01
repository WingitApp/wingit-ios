//
//  UserProfileViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//


import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

class UserProfileViewModel: ObservableObject {
    @Published var openPosts: [Post] = []
    @Published var closedPosts: [Post] = []
    
    @Published var isLoading = false
    @Published var isLoadingUser: Bool = false
    @Published var userBlocked = false
    @Published var connectionsCountState = 0
    @Published var showImagePicker: Bool = false
    
    @Published var isImageModalOpen: Bool = false

    var splitted: [[Post]] = []
    
    @Published var isConnected = false
    @Published var sentPendingRequest = false
    @Published var receivedPendingRequest = false
    
    @Published var user: User = USER_PROFILE_DEFAULT_PLACEHOLDER
    @Published var showOpenPosts = true
    var closedListener: ListenerRegistration!
    var openListener: ListenerRegistration!
    
    
  
  func fetchUserFromId(userId: String) {
    if !isLoadingUser {
      isLoadingUser.toggle()
    }
    if userId == "placeholder" {
        self.user = USER_PROFILE_DEFAULT_PLACEHOLDER
        return
    }
    Api.User.loadUser(
     userId: userId,
     onSuccess: { (user) in
      self.user = user
      if self.isLoadingUser {
        self.isLoadingUser.toggle()
      }
     },
     onError: {
         print("error")
     }
   )
  }
    
    func updateConnections(userId: String) {
        updateIsConnected(userId: userId)
        updateSentPendingRequest(userId: userId)
        updateConnectionsCount(userId: userId)
    }
    
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
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        Ref.FS_DOC_CONNECT_REQUEST_SENT(sentByUserId: currentUserId, receivedByUserId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.sentPendingRequest = true
            } else {
                self.sentPendingRequest = false
            }
        }
    }
    
    func updateReceivedPendingRequest(userId: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        Ref.FS_DOC_CONNECT_REQUEST_RECEIVED(receivedByUserId: currentUserId, sentFromUserId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.sentPendingRequest = true
            } else {
                self.sentPendingRequest = false
            }
        }
    }
  
    func loadUserPosts(userId: String?) {
      guard let userId = userId else { return }

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
        },
        newPost: { (post) in
          if !self.openPosts.isEmpty {
            if !self.openPosts.contains(post) {
              self.openPosts.insert(post, at: 0)
            }
          }
        },
        modifiedPost: { (post) in
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
        self.loadClosedPosts(userId: userId)
    }
    
    func loadClosedPosts(userId: String?) {
        guard let userId = userId else { return }
        isLoading = true
      
        Api.Post.loadClosedPosts(
          userId: userId,
          onEmpty: {
            self.isLoading = false
          },
          onSuccess: { (posts)  in
            if self.closedPosts.isEmpty {
                self.closedPosts = posts
                self.isLoading = false
            }
          },
          newPost: { (post) in
            if !self.closedPosts.isEmpty {
              if !self.closedPosts.contains(post) {
                self.closedPosts.insert(post, at: 0)
              }
            }
          },
          modifiedPost: { (post) in
              if !self.closedPosts.isEmpty {
                if let index = self.closedPosts.firstIndex(where: {$0.id == post.id}) {
                  self.closedPosts[index] = post
                }
              }
          
          },
          deletePost: { (post) in
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
    
    
    func updateConnectionsCount(userId: String?) {
        guard let userId = userId else { return }
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
                self.updateConnections(userId: postOwnerId)
                self.loadUserPosts(userId: postOwnerId)
                self.loadClosedPosts(userId: postOwnerId)
            }
        }
    }
}
}
