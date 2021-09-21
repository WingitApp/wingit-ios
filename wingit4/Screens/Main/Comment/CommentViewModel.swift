//
//  CommentViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//



import Foundation
import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false
    @Published var isCommentSheetShown = false

  
    var listener: ListenerRegistration!
    
    func toggleCommentScreen() {
      self.isCommentSheetShown.toggle()
    }
    
    func loadComments(postId: String) {
      if !self.isLoading {
        self.isLoading.toggle()
      }
          
      Api.Comment.getComments(
        postId: postId,
        onSuccess: { (comments) in
              if self.comments.isEmpty {
                  self.comments = comments
              }
          
              if self.isLoading {
                self.isLoading.toggle()
              }
          },
        onError: { (errorMessage) in
              // handle error
          },
        newComment: { (comment) in
              if !self.comments.contains(comment) {
                self.comments.append(comment)
                
                if self.isLoading {
                  self.isLoading.toggle()
                }
              }
          }) { (listener) in
              self.listener = listener
          }
      }

    
}
