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
  
    // Pagination State
    @Published var isLoadingNext: Bool = true
      
    private var canLoadMorePages = true
    private var next: Query?
      
    var listener: ListenerRegistration!
  
    func onSelectionChange(selection: Selection) {
      self.selection = selection
    }

  
    func loadMoreContentIfNeeded(currentItem post: Post?) {
       guard let post = post else { return }
         
      if let index = posts.firstIndex(where: { $0.postId == post.postId }) {
        if index == self.posts.count - 1 {
          loadTimelineNext()
        }
       }
     }
    
  
  func loadTimeline() {
        self.posts = []
        isLoading = true
        
        Api.Post.loadTimeline(
          firstCall: posts.count == 0,
          onEmpty: {
            self.isLoading = false
          },
          onSuccess: { (posts) in
            if self.posts.count < posts.count {
              self.posts = posts
              self.isLoading = false
            }
        }, newPost: { (post) in
            if !self.posts.isEmpty {
                if !self.posts.contains(post) {
                  self.posts.insert(post, at: 0)
                  self.posts.sort {
                    $0.date > $1.date
                  }
                }
            }
        }, modifiedPost: { (post) in
          if !self.posts.isEmpty {
            if let index = self.posts.firstIndex(where: {$0.id == post.id}) {
              self.posts[index] = post
            }
          }
          
        }, deletePost: { (post) in
            if !self.posts.isEmpty {
                for (index, p) in self.posts.enumerated() {
                    if p.postId == post.postId {
                        self.posts.remove(at: index)
                    }
                }
            }
        }, listener: { listenerHandler in
            self.listener = listenerHandler
        }, nextQuery: { next in
          self.next = next
        })
    }
  
  func toggleLoadingNextState(_ state: Bool) {
    withAnimation {
      self.isLoadingNext = state
    }
  }
  
  func loadTimelineNext() {
    toggleLoadingNextState(true)
    Api.Post.loadTimelinePaginated(
      next: self.next!,
      onSuccess: { posts, next in
        self.posts += posts
        self.next = next
        self.toggleLoadingNextState(false)
      },
      onEmpty: {
        self.toggleLoadingNextState(false)
      }
    )
  }
  
}
