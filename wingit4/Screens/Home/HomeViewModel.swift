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
   
      let thresholdIndex = posts.index(posts.endIndex, offsetBy: -5)
      if posts.firstIndex(where: { $0.postId == item.postId }) == thresholdIndex {
        loadTimeline()
      }
     }
  
    func loadTimeline() {
      if !self.isLoading {
        self.isLoading.toggle()
      }
      
      Api.Post.loadTimeline(
        onSuccess: { posts in
          self.posts = posts
          if self.isLoading {
            self.isLoading.toggle()
          }
        },
        listener: { (listener) in
          self.listener = listener
        })

    }
}
