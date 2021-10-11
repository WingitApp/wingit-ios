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
  @Published var isPostOwner: Bool = false

  func openCommentSheet(comment: Comment, isPostOwner: Bool, onOpen: @escaping() -> Void) {
    self.clean()
    guard let uid = Auth.auth().currentUser?.uid,
          let ownerId = comment.ownerId else { return }
    self.comment = comment
    self.isOwnComment = uid == ownerId
    self.isPostOwner = isPostOwner
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
  
  func addReaction(
    emojiCode: Int
  ) {
    
    // add reaction to comment sheet
    print("add reaction called")
    guard let currentUser = Auth.auth().currentUser else { return }
    print("currentUser:", currentUser)

    guard let comment = self.comment else { return }
    print("comment:", comment)


      
    let reaction: Reaction = Reaction(
      emojiCode: emojiCode,
      commentId: comment.docId,
      reactorId: currentUser.uid,
      avatarUrl: currentUser.photoURL!.absoluteString,
      username: currentUser.displayName!,
      createdAt: Date().timeIntervalSince1970
    )
    
    guard let reactionDict = try? reaction.toDictionary() else {return}
    print("reactionDict:", reactionDict)

    Api.Comment.postReaction(
      reactionDict: reactionDict,
      comment: comment
    ) {
      print("add reaction callback")
      self.bottomSheetPosition = .hidden
      self.clean()
    }
  }
  
  
  
}
