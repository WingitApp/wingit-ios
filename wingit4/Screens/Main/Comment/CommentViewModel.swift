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
    @Published var isLoading = false
    @Published var isCommentSheetShown = false
  
    var listener: ListenerRegistration!
  
    func toggleCommentScreen() {
      self.isCommentSheetShown.toggle()
    }
    
    func loadComments(postId: String) {
        self.isLoading = true
          
      Api.Comment.getComments(
        postId: postId,
        onSuccess: { (comments) in
              if self.comments.isEmpty {
                  self.comments = comments
              }
          },
        onError: { (errorMessage) in
              
          },
        newComment: { (comment) in
              if !self.comments.isEmpty {
                  self.comments.append(comment)
              }
          }) { (listener) in
              self.listener = listener
          }
      }
    
}
