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
    @Published var followersCountState = 0
    @Published var followingCountState = 0
    @Published var showImagePicker: Bool = false
    @Published var offset: CGFloat = 0

    var splitted: [[Post]] = []
    
    @Published var isFollowing = false
    
    
    func checkFollow() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isFollowing = true
            } else {
                self.isFollowing = false
            }
        }
    }
    
    func loadUserPosts() {
      if !self.isLoading {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        self.isLoading.toggle()

        Api.User.loadPosts(userId: userId) { (posts) in
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
            self.isLoading.toggle()



        }
        checkFollow()
        updateFollowCount()
        self.loadDonePosts()
      }
    }
    
    
    func loadDonePosts() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
 
    
    func updateFollowCount() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId).getDocuments { (snapshot, error) in
            
            if let doc = snapshot?.documents {
                self.followingCountState = doc.count
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments { (snapshot, error) in
             if let doc = snapshot?.documents {
                self.followersCountState = doc.count
             }
         }
    }
}
