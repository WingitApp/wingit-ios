//
//  CommentInput.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage


struct CommentInput: View {
  // VM
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var commentViewModel: CommentViewModel
  @EnvironmentObject var commentInputViewModel: CommentInputViewModel
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel
  
  // Props & State
  @Binding var post: Post?
  var scrollProxyValue: ScrollViewProxy?
  @State var composedMessage: String = ""
  
  
  
  func onCommentSubmit() {
    if !composedMessage.isEmpty {
      Haptic.impact(type: "medium")
      let trimmedText = composedMessage.trimmingCharacters(in: .whitespacesAndNewlines)
      self.commentInputViewModel.saveComment(
        text: trimmedText,
        post: post
      ) {
        // clean message
        self.composedMessage = ""
        
        //scroll to comment on appear
        guard let scrollProxy = scrollProxyValue else { return }
        withAnimation {
          scrollProxy.scrollTo(commentViewModel.comments.count - 1)
        }
      }
    } else {
      //TODO: show feedback message
    }
  }
  
  func toggleCommentEdit() {
    
  }
  
  
  var body: some View {
    VStack() {
      if commentSheetViewModel.isEditingComment {
        Divider()
        HStack(alignment: .bottom){
          TextView(
            "",
            text: $commentSheetViewModel.commentEditText,
            isFocused: $commentSheetViewModel.isEditingComment
          )
          Button(action: commentSheetViewModel.onCommentEditSubmit) {
            Image(systemName: "arrow.up.circle.fill")
              .font(.system(size:23))
              .foregroundColor(.wingitBlue)
          }
          .padding(.top, 8)
        }
        .padding(
          EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        )
      } else {
        Divider()
        HStack(alignment: .bottom){
          TextView(
            "Write a response",
            text: $composedMessage,
            isFocused: $commentViewModel.isTextFieldFocused
          )
          Button(action: onCommentSubmit) {
            Image(systemName: "arrow.up.circle.fill")
              .font(.system(size:23))
              .foregroundColor(.wingitBlue)
          }
          .padding(.top, 8)
        }
        .padding(
          EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        )
      }
    }
    
  }
}
