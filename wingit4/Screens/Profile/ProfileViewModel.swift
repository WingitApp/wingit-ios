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
    @Published var openPosts: [Post] = []
    @Published var closedPosts: [Post] = []
    var user: User!

    @Published var isLoading = false
    @Published var userBlocked = false
    @Published var showImagePicker: Bool = false
    @Published var connectionsCountState = 0
  
    @Published var isUpdatePicSheetOpen: Bool = false
    
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

      Api.Post.loadOpenPosts(userId: userId) { (posts) in
          self.openPosts = posts
          if self.isLoading {
            self.isLoading.toggle()
          }
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
