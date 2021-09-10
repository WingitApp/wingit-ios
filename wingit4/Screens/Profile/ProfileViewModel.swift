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
    @Published var doneposts: [DonePost] = []
    var user: User!

    @Published var isLoading = false
    @Published var userBlocked = false
    @Published var showImagePicker: Bool = false
    @Published var offset: CGFloat = 0
    @Published var connectionsCountState = 0

    var splitted: [[Post]] = []
    
    @Published var isConnected = false
    
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
      if !self.isLoading {
        self.isLoading.toggle()
      }
      
      guard let userId = Auth.auth().currentUser?.uid else { return }

      Api.User.loadPosts(userId: userId) { (posts) in
          self.posts = posts
          if self.isLoading {
            self.isLoading.toggle()
          }
      }
    // these calls should be called elsewhere
      updateIsConnected(userId: userId)
      updateConnectionsCount(userId: userId)
      self.loadDonePosts()
    }
    
    
    func loadDonePosts() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
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
