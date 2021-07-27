//
//  HomeViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import SwiftUI
import Firebase


class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var gemposts: [gemPost] = []
    @Published var isLoading = false
   
    var listener: ListenerRegistration!
//    init() {
//        loadTimeline()
//    }
    
    
    func loadTimeline() {
        self.posts = []
        isLoading = true
        
        Api.Post.loadTimeline(onSuccess: { (posts) in
            self.isLoading = false
            if self.posts.isEmpty {
                self.posts = posts
            }
        }, newPost: { (post) in
            if !self.posts.isEmpty {
                self.posts.insert(post, at: 0)

            }
        }, deletePost: { (post) in
            if !self.posts.isEmpty {
                for (index, p) in self.posts.enumerated() {
                    if p.postId == post.postId {
                        self.posts.remove(at: index)

                    }
                }
            }
        }) { (listener) in
            self.listener = listener
        }
    }
    
    func loadGemTimeline() {
        self.gemposts = []
        isLoading = true
        
        Api.gemPost.loadTimeline(onSuccess: { (gemposts) in
            self.isLoading = false
            if self.gemposts.isEmpty {
                self.gemposts = gemposts
            }
        }, newPost: { (gempost) in
            if !self.gemposts.isEmpty {
                self.gemposts.insert(gempost, at: 0)

            }
        }, deletePost: { (gempost) in
            if !self.gemposts.isEmpty {
                for (index, p) in self.gemposts.enumerated() {
                    if p.postId == gempost.postId {
                        self.gemposts.remove(at: index)

                    }
                }
            }
        }) { (listener) in
            self.listener = listener
        }
    }
}
