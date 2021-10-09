//
//   CommentSheetViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 10/9/21.
//

import SwiftUI
import FirebaseAuth
import BottomSheet
import SPAlert


class CommentSheetViewModel: ObservableObject {
  @Published var searchText: String = ""

  @Published var bottomSheetPosition: BottomSheetPosition = .hidden
  @Published var isEmojiKeyboardActive: Bool = false
  @Published var comment: Comment? = nil
  @Published var isOwnComment: Bool = false

  func openCommentSheet(comment: Comment, onOpen: @escaping() -> Void) {
    self.clean()
    guard let uid = Auth.auth().currentUser?.uid,
          let ownerId = comment.ownerId else { return }
    self.isOwnComment = uid == ownerId
    self.comment = comment
    self.bottomSheetPosition = .middle
    
    onOpen()
  }
  
  func closeCommentSheet(onClose: @escaping () -> Void) {
    self.bottomSheetPosition = .hidden
    self.clean()
    onClose()
  }
  
  func clean() {
    self.isEmojiKeyboardActive = false
    self.comment = nil
  }
  
  func copyText() {
    UIPasteboard.general.string = comment?.comment ?? ""
    closeCommentSheet() {
      SPAlertView(
        title: "",
        message: "Text Copied!",
        preset: SPAlertIconPreset.done
      ).present(duration: 1)
    }
    
  }
  
  func toggleEmojiKeyboard() {
    isEmojiKeyboardActive.toggle()
    if isEmojiKeyboardActive {
//      self.bottomSheetPosition = .top
    } else {
      self.bottomSheetPosition = .middle
    }
  }
    
  func editComment() {
    
  }
  
  func deleteComment() {
    
  }
  
  func selectReaction(emojiCode: Int) {
    // add reaction to comment sheet
  }
  
  
  
}
