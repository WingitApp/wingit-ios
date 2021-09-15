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
    @Published var emptyState = false
    
    private var canLoadMorePages = true
    private var next: Query? =  TIMELINE_PAGINATION_QUERY
      
    var listener: ListenerRegistration!
  
    func onSelectionChange(selection: Selection) {
      self.selection = selection
    }

  
    func loadMoreContentIfNeeded(currentItem item: Post?) {
       guard let item = item else {
         return
       }
   
      let thresholdIndex = posts.index(posts.endIndex, offsetBy: -1)
      
      if posts.firstIndex(where: { $0.postId == item.postId }) == thresholdIndex {
        print("call next")
        loadTimelineNext()
      }
      
     }
  
  func loadTimeline() {
        self.posts = []
        isLoading = true
        emptyState = true
        
        Api.Post.loadTimeline(
          firstCall: posts.count == 0,
          onSuccess: { (posts) in
            if self.posts.count < posts.count {
              self.posts = posts
              self.isLoading = false
              self.emptyState = false
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
  
  func loadTimelineNext() {
    Api.Post.loadTimelinePaginated(
      next: self.next!,
      onSuccess: { posts, next in
        self.posts += posts
        self.next = next
      }
    )
  }
  
}
