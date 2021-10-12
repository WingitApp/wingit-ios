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
  @Published var isTopComment: Bool = false
  @Published var reactions: [Reaction] = []
  
  func openCommentSheet(comment: Comment, isPostOwner: Bool, isTopComment: Bool, reactions: [Reaction] = [], showEmojiKeyboard: Bool? = false, onOpen: @escaping() -> Void) {
    self.clean()
    guard let uid = Auth.auth().currentUser?.uid,
          let ownerId = comment.ownerId else { return }
    self.comment = comment
    self.isOwnComment = uid == ownerId
    self.isPostOwner = isPostOwner
    self.isTopComment = isTopComment
    self.bottomSheetPosition = .middle
    
    self.reactions = reactions
    self.isEmojiKeyboardActive = showEmojiKeyboard ?? false
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
    Haptic.impact(type: "soft")
    isEmojiKeyboardActive.toggle()
    if !isEmojiKeyboardActive {
      self.bottomSheetPosition = .middle
    }
  }
  
  
  func editComment() {
    
  }
  
  func deleteComment() {
    Haptic.impact(type: "soft")
    guard let comment = self.comment else {return}
    Api.Comment.deleteComment(comment: comment) {
      self.closeCommentSheet() {
        SPAlertView(
          title: "",
          message: "Comment Deleted!",
          preset: SPAlertIconPreset.done
        ).present(duration: 1)
      }
    }
  }
  
  
  func handleReactionTap(
    _ emojiCode: Int
  ) {
    Haptic.impact(type: "soft")
    guard let userId = Auth.auth().currentUser?.uid else { return }
    guard let comment = self.comment else { return }
    var userReaction = self.reactions.filter { $0.reactorId == userId && $0.emojiCode == emojiCode }
    
    if userReaction.isEmpty {
      addReaction(emojiCode)
    } else {
      let reaction = userReaction[0]
      removeReaction(reaction, comment)
    }
    
  }
  
  func removeReaction(_ reaction: Reaction, _ comment: Comment) {
    self.bottomSheetPosition = .hidden
    
    Api.Comment.deleteReaction(reaction: reaction, comment: comment) {
      self.clean()
    }
  }
  
  
  func addReaction(
    _ emojiCode: Int
  ) {
    
    // add reaction to comment sheet
    guard let currentUser = Auth.auth().currentUser else { return }
    guard let comment = self.comment else { return }
    
    let reactionDict = [
      "id": UUID().uuidString,
      "emojiCode": emojiCode,
      "commentId": comment.docId ?? comment.id,
      "reactorId": currentUser.uid,
      "avatarUrl": currentUser.photoURL!.absoluteString,
      "username": currentUser.displayName!,
      "createdAt": Date().timeIntervalSince1970
    ] as [String : Any]
    
    self.bottomSheetPosition = .hidden
    
    Api.Comment.postReaction(
      reactionDict: reactionDict,
      comment: comment
    ) {
      self.clean()
    }
  }
  
  func markCommentAsBest(post: Post?) {
    Haptic.impact(type: "soft")
    
    guard let post = post,
          let comment = self.comment else {return}
    
    guard let postId = post.id,
          let commentId = comment.id else {return}
    
    
    Api.Post.updatePostTopComment(
      postId: postId,
      commentId: commentId,
      remove: isTopComment
    ) { state in
      print("top comment marked")
    }
  }
  
  
  
}
