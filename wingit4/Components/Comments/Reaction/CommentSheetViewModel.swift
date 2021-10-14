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
  // emoji search
  @Published var searchText: String = ""
  
  @Published var bottomSheetPosition: BottomSheetPosition = .hidden
  @Published var isEmojiKeyboardActive: Bool = false
  @Published var comment: Comment? = nil
  @Published var isOwnComment: Bool = false
  @Published var isOwnPost: Bool = false
  @Published var isTopComment: Bool = false
  @Published var reactions: [Reaction] = []
  
  // Comment Deletion State
  @Published var isConfirmationShown: Bool = false
  
  // Comment Editing State
  @Published var isEditingComment: Bool = false
  @Published var commentEditText: String = ""
  var scrollToComment: (() -> Void)? = nil
  
  @Published var currentTopCommentId: String? = nil
  

  func openCommentSheet(
    comment: Comment,
    isOwnPost: Bool, // should get from post
    reactions: [Reaction] = [],
    showEmojiKeyboard: Bool? = false,
    scrollToComment: (() -> Void)?,
    onOpen: @escaping() -> Void
  ) {
    self.comment = comment
    self.isOwnPost = isOwnPost
    self.isOwnComment = comment.isOwn ?? false
    self.isTopComment = comment.isTopComment ?? false
    self.reactions = reactions
    self.isEmojiKeyboardActive = showEmojiKeyboard ?? false
    self.scrollToComment = scrollToComment
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
  }
  
  func copyText() {
    UIPasteboard.general.string = comment?.comment ?? ""
    closeCommentSheet {
      SPAlertView(
        title: "",
        message: "Text Copied",
        preset: SPAlertIconPreset.custom(UIImage(systemName: "doc.on.doc")!)
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
  
  
  func toggleCommentEditState() {
    self.commentEditText = ""
    self.isEditingComment.toggle()
    self.bottomSheetPosition = .hidden
    // hacky way to force comment input to readjust height
    DispatchQueue.main.asyncAfter(deadline:  DispatchTime.now() + 0.1) {
      self.commentEditText = self.comment?.comment ?? ""
      guard let scrollToComment = self.scrollToComment else { return }
      scrollToComment()
      Haptic.impact(type: "small")
    }
  }
  
  func onCommentEditSubmit() {
    guard let comment = self.comment else {return}

    if comment.comment == commentEditText {
      SPAlertView(
        title: "",
        message: "No changes detected",
        preset: SPAlertIconPreset.custom(UIImage(systemName: "note.text")!)
      ).present(duration: 1)
      return
    }
    
    if commentEditText.trim().isEmpty {
      SPAlertView(
        title: "",
        message: "Comment cannot be empty",
        preset: SPAlertIconPreset.custom(UIImage(systemName: "note")!)
      ).present(duration: 1)
      return
    }
    Api.Comment.editComment(
      updatedText: commentEditText.trim(),
      commentId: comment.docId,
      postId: comment.postId
    ) {
      self.closeCommentSheet {
        self.isEditingComment = false
        SPAlertView(
          title: "",
          message: "Comment Edited!",
          preset: SPAlertIconPreset.done
        ).present(duration: 1)
      }
    }
  }
  
  func deleteCommentConfirmation() {
    Haptic.impact(type: "soft")
    self.isConfirmationShown = true
  }
  
  func deleteComment() {
    guard let comment = self.comment else {return}
    Api.Comment.deleteComment(comment: comment) {
      self.closeCommentSheet {
        SPAlertView(
          title: "",
          message: "Comment Deleted",
          preset: SPAlertIconPreset.done
        ).present(duration: 1)
      }
    }
  }
  
  func unmarkCommentAsBest(postId: String, commentId: String) {
    Api.Comment.removeTopCommentStatus(
      postId: postId,
      commentId: commentId
    ) {
      self.currentTopCommentId = nil
      self.closeCommentSheet {
        SPAlertView(
          title: "",
          message: "Comment Unmarked",
          preset: SPAlertIconPreset.custom(UIImage(systemName: "hand.thumbsup")!)
        ).present(duration: 1)
      }
    }
  }
  
  func markCommentAsBest(post: Post?) {
    Haptic.impact(type: "soft")
    
    guard let post = post,
          let comment = self.comment else {return}
    
    guard let postId = post.id,
          let commentId = comment.docId else {return}

    
    if currentTopCommentId == nil {
      Api.Comment.addTopCommentStatus(
        comment: comment
      ) {
        self.closeCommentSheet {
          SPAlertView(
            title: "",
            message: "Marked as Top Answer",
            preset: SPAlertIconPreset.custom(UIImage(systemName: "hand.thumbsup.fill")!)
          ).present(duration: 1)
        }
      }
    } else {
      // remove the top comment status of existing comment
      guard let currentTopCommentId = currentTopCommentId else {return}
      if currentTopCommentId == comment.docId { return self.unmarkCommentAsBest(postId: postId, commentId: commentId) }
      
      Api.Comment.removeTopCommentStatus(
        postId: postId,
        commentId: currentTopCommentId
      ) {
        // add top comment status to comment
        Api.Comment.addTopCommentStatus(
          comment: comment
        ) {
          self.closeCommentSheet {
            SPAlertView(
              title: "",
              message:  "Marked as Top Answer",
              preset: SPAlertIconPreset.custom(UIImage(systemName: "hand.thumbsup.fill")!)
            ).present(duration: 1)
          }
        }
      }
    }
  }
  
}

// Handles Reactions

extension CommentSheetViewModel {
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
      "id": currentUser.id as Any,
      "uid": currentUser.uid as Any,
      "firstName": currentUser.firstName as Any,
      "lastName": currentUser.lastName as Any,
      "avatar": currentUser.profileImageUrl as Any,
      "username": currentUser.username as Any,
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
