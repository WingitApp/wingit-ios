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
    @Published var isLoading = false
    @Published var selection: Selection = .posts
    @Published var isFetching: Bool = true

    
    var user: User!
   
    var listener: ListenerRegistration!
  
  func onSelectionChange(selection: Selection) {
    print("SELECTION: \(selection)")
    self.selection = selection
    print("SELF.SELECTION: \(self.selection)")

  }
    func loadTimeline() {
        self.posts = []
        isLoading = true
        
        Api.Post.loadTimeline(
          onSuccess: { (posts) in
            if self.posts.isEmpty {
                self.posts = posts
              self.isLoading = false
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
}
