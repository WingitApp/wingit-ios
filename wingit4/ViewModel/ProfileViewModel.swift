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
    
    @Published var isLoading = false
    @Published var userBlocked = true
    @Published var followersCountState = 0
    @Published var followingCountState = 0
    @Published var showImagePicker: Bool = false
   // var user: User!

    var splitted: [[Post]] = []
    
    @Published var isFollowing = false
    
    
    func checkFollow(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isFollowing = true
            } else {
                self.isFollowing = false
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
        checkFollow(userId: userId)
        updateFollowCount(userId: userId)
        self.loadDonePosts(userId: userId)
    }
    
    
    func loadDonePosts(userId: String) {
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
 
    
    func updateFollowCount(userId: String) {
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
    
    func checkUserBlocked(userId: String, postOwnerId: String){
        Ref.FIRESTORE_COLLECTION_BLOCKED_USERID(userId: userId).collection("userBlocked").document(postOwnerId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                return
            }; Ref.FIRESTORE_COLLECTION_BLOCKED_USERID(userId: userId).collection("userBlockedBy").document(postOwnerId).getDocument { (document, error) in
                if let doc = document, doc.exists {
                    return
                } else {
                self.loadUserPosts(userId: postOwnerId)
              //  self.loadDonePosts(userId: postOwnerId)
                self.userBlocked = false
            }
        }
    }
}
        
}
        
    

        


