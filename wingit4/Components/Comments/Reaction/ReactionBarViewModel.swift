//
//  ReactionBarViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 10/11/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

class ReactionBarViewModel: ObservableObject {
  @Published var isFetchingReactions: Bool = false
  @Published var reactions: [Reaction] = []
  @Published var listener: ListenerRegistration?
  
  
  func fetchReactions(comment: Comment) {
    isFetchingReactions = true
    self.reactions = []
    Api.Comment.getReactionsByComment(
      comment: comment,
      onEmpty: {
        self.isFetchingReactions = false
      },
      onSuccess: { reactions in
        if self.reactions.count >= reactions.count { return }
        self.reactions = reactions
        self.isFetchingReactions = false
        
      },
      newReaction: { reaction in
        if self.reactions.contains(reaction) { return }
        self.reactions.append(reaction)
      },
      modifiedReaction: { reaction in
        if self.reactions.isEmpty { return }
        if let index = self.reactions.firstIndex(
          where: { $0.id == reaction.id }
        ) {
          self.reactions[index] = reaction
        }
      },
      removedReaction: { reaction in
        if self.reactions.isEmpty { return }
        for (index, r) in self.reactions.enumerated() {
            if r.id == reaction.id {
                self.reactions.remove(at: index)
            }
        }

      }
    ) { listenerHandler in
      self.listener = listenerHandler
    }
  }
  
  
  func createReaction(
    _ reaction: Reaction,
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
      "id": String(reaction.emojiCode),
      "emojiCode": reaction.emojiCode,
      "commentId": comment.docId ?? comment.id as Any,
      "createdAt": Date().timeIntervalSince1970,
      "reactors": [currentUser.id: userPreviewDict]
    ] as [String : Any]
    
    Api.Comment.postReaction(
      reactionDict: reactionDict,
      comment: comment
    ) {
      // do something
    }
  }
  
  func deleteReaction(
    _ reaction: Reaction,
    _ comment: Comment
  ) {
    Api.Comment.deleteReaction(reaction: reaction, comment: comment) {
      // do something after reaction is removed
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
    
  

    Api.Comment.addUserReaction(
      reaction: reaction,
      comment: comment,
      newReactor: userPreviewDict
    ) {

    }
  }
  
  func removeUserReaction(
    _ reaction: Reaction,
    _ comment: Comment
  ) {
    
    Api.Comment.removeUserReaction(
      reaction: reaction,
      comment: comment
    ) {

    }
  }
  
  
  
  func handleReactionTap(
    reaction: Reaction,
    comment: Comment?, // needed for post & commentId
    currentUser: User?
  ) {
    Haptic.impact(type: "soft")
    guard let currentUser = currentUser else { return }
    guard let comment = comment else { return }
    
    if reactions.isEmpty {
      createReaction(
        reaction,
        comment,
        currentUser
      )
    } else if !reaction.hasCurrentUser {
      addUserReaction(
        reaction,
        comment,
        currentUser
      )
    } else if reaction.count == 1{
      deleteReaction(
        reaction,
        comment
      )
    } else {
      removeUserReaction(
        reaction,
        comment
      )
    }
  }
}
