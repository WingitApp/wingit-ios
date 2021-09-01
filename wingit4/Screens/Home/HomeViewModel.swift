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
    private var next: Query? = Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(
      userId: Auth.auth().currentUser!.uid)
      .collection("timelinePosts")
      .order(by: "date", descending: true)
      .limit(to: 5)
      
    var listener: ListenerRegistration!
  
    func onSelectionChange(selection: Selection) {
      self.selection = selection
    }
  
    func loadMoreContent() {
      self.loadTimeline()
    }
  
    func loadMoreContentIfNeeded(currentItem item: Post?) {
       guard let item = item else {
         return
       }
   
       let thresholdIndex = posts.index(posts.endIndex, offsetBy: -5)
       if posts.firstIndex(where: { $0.postId == item.postId }) == thresholdIndex {
         loadMoreContent()
       }
     }
  
    func loadTimeline() {
        isLoading = true
        
        Api.Post.loadTimeline(
          next: self.next!,
          onSuccess: { (posts, next) in
              self.posts = self.posts + posts
              self.next = next
              self.isLoading = false
          }
        )
    }
}
