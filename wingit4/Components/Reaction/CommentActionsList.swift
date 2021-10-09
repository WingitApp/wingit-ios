//
//  CommentSheet.swift
//  wingit4
//
//  Created by Joshua Lee on 10/7/21.
//

import SwiftUI


struct CommentActionsList: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel

    func editComment() {
      print("edit comment")
    }
    
    func copyText() {
      print("copy text")
    }
    
    func reactions() {
//        isEmojiKeyboardActive = true
    }
  
    func deleteMessage() {
      print("delete message")
    }
  
    func clean() {
//      isEmojiKeyboardActive = false
    }
  
    var body: some View {
        VStack(spacing: 0){
          if commentSheetViewModel.isEmojiKeyboardActive {
            EmojiKeyboard()
          } else {
            ScrollView {
              VStack(spacing: 0) {
                CommentActionEntry(
                  icon: "square.and.pencil",
                  label: "Edit Comment",
                  showDivider: true,
                  onTap: editComment,
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
                  onTap: deleteMessage,
                  isShown: commentSheetViewModel.isOwnComment
                )
                if commentSheetViewModel.isOwnComment { Divider() }
                Spacer()
              }
            }
            
          }
         
        }
    }
}
