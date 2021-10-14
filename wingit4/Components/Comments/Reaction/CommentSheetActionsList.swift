//
//  CommentSheet.swift
//  wingit4
//
//  Created by Joshua Lee on 10/7/21.
//

import SwiftUI


struct CommentSheetActionsList: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel
  var post: Post?

  func markCommentAsBest() {
    commentSheetViewModel.markCommentAsBest(post: post) 
  }
  
    var body: some View {
        VStack(spacing: 0){
          if commentSheetViewModel.isEmojiKeyboardActive {
            EmojiKeyboard()
          } else {
            ScrollView {
              VStack(spacing: 0) {
                CommentActionEntry(
                  icon: commentSheetViewModel.isTopComment ? "hand.thumbsup.fill" : "hand.thumbsup",
                  label: commentSheetViewModel.isTopComment ? "Unmark Answer as Best" : "Mark as Best Answer",
                  showDivider: true,
                  onTap: markCommentAsBest,
                  isShown: commentSheetViewModel.isOwnPost && !commentSheetViewModel.isOwnComment
                )
                if commentSheetViewModel.isOwnPost { Divider() }
                CommentActionEntry(
                  icon: "square.and.pencil",
                  label: "Edit Comment",
                  showDivider: true,
                  onTap: commentSheetViewModel.toggleCommentEditState,
                  isShown: commentSheetViewModel.isOwnComment
                )
                if commentSheetViewModel.isOwnComment { Divider() }
                CommentActionEntry(
                  icon: "doc.on.doc",
                  label: "Copy Text",
                  showDivider: true,
                  onTap: commentSheetViewModel.copyText,
                  isShown: true
                )
                Divider()
                CommentActionEntry(
                  icon: "face.smiling",
                  label: "Add Reactions",
                  showDivider: true,
                  onTap: commentSheetViewModel.toggleEmojiKeyboard,
                  isShown: true
                )
                Divider()
                CommentActionEntry(
                  icon: "trash",
                  label: "Delete Message",
                  showDivider: true,
                  onTap: commentSheetViewModel.deleteCommentConfirmation,
                  isShown: commentSheetViewModel.isOwnComment
                )
                if commentSheetViewModel.isOwnComment { Divider() }
              }
            }
            
          }
         
        }
    }
}
