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
    emojiCode: Int,
    currentUser: User?
  ) {
    Haptic.impact(type: "soft")
    guard let currentUser = currentUser else { return }
    guard let comment = self.comment else { return }
    
    let reaction = reactions.filter {
      $0.emojiCode == emojiCode
    }

    if reaction.isEmpty {
      createReaction(
        emojiCode,
        comment,
        currentUser
      )
    } else if !reaction[0].hasCurrentUser {
      addUserReaction(
        reaction[0],
        comment,
        currentUser
      )
    } else if reaction[0].count == 1{
      deleteReaction(
        reaction[0],
        comment
      )
    } else {
      removeUserReaction(
        reaction[0],
        comment
      )
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
  
  func createReaction(
    _ emojiCode: Int,
    _ comment: Comment,
    _ currentUser: User
  ) {
        
    // create userPreview dict
    let userPreviewDict = [
      "id": currentUser.id as Any,
      "uid": currentUser.uid as Any,
      "firstName": currentUser.firstName as Any,
      "lastName": currentUser.lastName as Any,
      "avatar": currentUser.profileImageUrl as Any,
      "username": currentUser.username as Any,
      "interactedAt": Date().timeIntervalSince1970
    ] as [String : Any]
      
    // create reaction dict
    let reactionDict = [
      "id": String(emojiCode),
      "emojiCode": emojiCode,
      "commentId": comment.docId ?? comment.id as Any,
      "createdAt": Date().timeIntervalSince1970,
      "reactors": [currentUser.id: userPreviewDict]
    ] as [String : Any]
    
    self.bottomSheetPosition = .hidden
    Api.Comment.postReaction(
      reactionDict: reactionDict,
      comment: comment
    ) {
      self.clean()
    }
  }
  
  func deleteReaction(
    _ reaction: Reaction,
    _ comment: Comment
  ) {
    self.bottomSheetPosition = .hidden
    Api.Comment.deleteReaction(reaction: reaction, comment: comment) {
      self.clean()
    }
  }
  
  
  
  func addUserReaction(
    _ reaction: Reaction,
    _ comment: Comment,
    _ currentUser: User
  ) {
    
    let userPreviewDict = [
      "id": currentUser.id,
      "uid": currentUser.uid,
      "firstName": currentUser.firstName,
      "lastName": currentUser.lastName,
      "avatar": currentUser.profileImageUrl,
      "username": currentUser.username,
      "interactedAt": Date().timeIntervalSince1970
    ] as [String : Any]
    
  
    self.bottomSheetPosition = .hidden
    Api.Comment.addUserReaction(
      reaction: reaction,
      comment: comment,
      newReactor: userPreviewDict
    ) {
      self.clean()
    }
  }
  
  func removeUserReaction(
    _ reaction: Reaction,
    _ comment: Comment
  ) {
    self.bottomSheetPosition = .hidden
    Api.Comment.removeUserReaction(
      reaction: reaction,
      comment: comment
    ) {
      self.clean()
    }
  }
  
  
}
