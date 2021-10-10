//
//  SessionStore.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import SwiftUI

class SessionStore: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: User?
    @Published var isSessionLoading: Bool = true
  
    // migrated profileViewModel
  
    // User's Open Posts
    @Published var openPosts: [Post] = []
    @Published var isFetchingUserOpenPosts = false
    private var openListener: ListenerRegistration!
    // User's Closed Posts
    @Published var closedPosts: [Post] = []
    @Published var isFetchingUserClosedPosts = false
    private var closedListener: ListenerRegistration!
    // User's Connections
    @Published var connections: [User] = []
    @Published var isFetchingConnections: Bool = false
    // User Image
    @Published var isUpdatePicSheetOpen: Bool = false
    @Published var isEditSheetOpen: Bool = false
    // User Posts Toggle
    @Published var showPosts = false
    @Published var showOpenPosts = true
    // User Link Toggle
    @Published var showLinks = false
    // User Metadata
    @Published var bio: String = ""
  
  
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @AppStorage("notificationsLastSeenAt") var notificationsLastSeenAt: Double = 1633809770
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                Api.User.loadUser(
                    userId: user.uid,
                    onSuccess: { (decodedUser) in
                        // user successfully found
                        self.currentUser = decodedUser
                        self.initializeAppStorageCache(user: decodedUser)
                        Api.Device.updateDeviceInFirestore(token: "")
                        self.isLoggedIn = true
                        self.isSessionLoading = false
                    },
                    onError: {
                        // todo: user doc DNE
                        print("error fetching user")
                        self.isLoggedIn = true
                        self.isSessionLoading = false

                })
            } else {
                self.isLoggedIn = false
                self.currentUser = nil
                self.isSessionLoading = false
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            shouldShowOnboarding = true
            logToAmplitude(event: .userLogout, userId: self.currentUser?.id)
        } catch  {

        }
    }
    
    // stop listening for auth changes
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}

extension SessionStore {


  func loadUserProfile() {
    self.loadUserConnections()
    self.loadUserOpenPosts()
    self.loadClosedPosts()
  }
  
  func initializeAppStorageCache (user: User) {
    notificationsLastSeenAt = Double(user.notificationsLastSeenAt?.seconds ?? 1633809770)
  }


  func loadUserConnections() {
      guard let userId = Auth.auth().currentUser?.uid else { return }
      isFetchingConnections = true
      Api.Connections.getConnections(
          userId: userId,
          onSuccess: { connections in
              self.connections = connections.sorted(by: { $0.firstName! < $1.firstName!})
              self.updateConnectionsCount(count: connections.count)
              self.isFetchingConnections = false
          },
          onEmpty: { self.isFetchingConnections = false }
      )
  }

  func loadUserOpenPosts() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    self.openPosts = []
    self.isFetchingUserOpenPosts = true
    
    Api.Post.loadOpenPosts(
      userId: userId,
      onEmpty: { self.isFetchingUserOpenPosts = false },
      onSuccess: { (posts) in
        if self.openPosts.isEmpty {
          self.openPosts = posts
          self.isFetchingUserOpenPosts = false
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
  }

  
  func loadClosedPosts() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    self.closedPosts = []
    self.isFetchingUserClosedPosts = true
  
    Api.Post.loadClosedPosts(
      userId: userId,
      onEmpty: { self.isFetchingUserClosedPosts = false },
      onSuccess: { (posts) in
        if self.closedPosts.isEmpty {
            self.closedPosts = posts
            self.isFetchingUserClosedPosts = false
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
  
  func updateConnectionsCount(count: Int) {
    setUserProperty(property: .connections, value: count)
  }
  
func editProfile(bio: String, completed: @escaping() -> Void){
          Api.User.editProfile(
              bio: bio,
              onSuccess: completed
          )
  }
}
