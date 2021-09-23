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
    @Published var inviteHistory: [Comment] = []
  
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
        onSuccess: { (allComments) in
              if self.comments.isEmpty {
                var comments: [Comment] = []
                var inviteHistory: [Comment] = []
                
                for comment in allComments {
                  if comment.type == .invitedReferral {
                    inviteHistory.append(comment)
                  } else {
                    comments.append(comment)
                  }
                }
                self.comments = comments
                self.inviteHistory = inviteHistory
              }
          
              if self.isLoading {
                self.isLoading.toggle()
              }
          },
        onError: { (errorMessage) in
              // handle error
          },
        newComment: { (comment) in
          if comment.type == .invitedReferral {
            if !self.inviteHistory.contains(comment) {
              self.inviteHistory.append(comment)
            }
          } else {
            if !self.comments.contains(comment) {
              self.comments.append(comment)
            }
          }
            
          if self.isLoading {
            self.isLoading.toggle()
          }

          }) { (listener) in
              self.listener = listener
          }
      }

    
}
