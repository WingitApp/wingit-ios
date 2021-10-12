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
  @Published var uniqueReactions: [Reaction] = []
//  @Published var uniqueReactions: [Reaction] = []
  @Published var listener: ListenerRegistration?
  
  func formatDictionary() {
    self.uniqueReactions = Array(Set(self.reactions))
  }
  
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
        self.formatDictionary()
        self.isFetchingReactions = false
        
      },
      newReaction: { reaction in
        if self.reactions.contains(reaction) { return }
        self.reactions.append(reaction)
        self.formatDictionary()
      },
      modifiedReaction: { reaction in
        if self.reactions.isEmpty { return }
        if let index = self.reactions.firstIndex(
          where: { $0.id == reaction.id }
        ) {
          self.reactions[index] = reaction
        }
        self.formatDictionary()
      },
      removedReaction: { reaction in
        if self.reactions.isEmpty { return }
        for (index, r) in self.reactions.enumerated() {
            if r.id == reaction.id {
                self.reactions.remove(at: index)
            }
        }
        self.formatDictionary()

      }
    ) { listenerHandler in
      self.listener = listenerHandler
    }
  }
  
  func removeReaction(_ reaction: Reaction, _ comment: Comment) {
    Api.Comment.deleteReaction(reaction: reaction, comment: comment) {
    }
  }
  
  func addReaction(
    _ emojiCode: Int,
    _ comment: Comment?
  ) {
    
    // add reaction to comment sheet
    guard let currentUser = Auth.auth().currentUser else { return }
    guard let comment = comment else { return }
      
    let reactionDict = [
      "id": UUID().uuidString,
      "emojiCode": emojiCode,
      "commentId": comment.docId ?? comment.id,
      "reactorId": currentUser.uid,
      "avatarUrl": currentUser.photoURL!.absoluteString,
      "username": currentUser.displayName!,
      "createdAt": Date().timeIntervalSince1970
    ] as [String : Any]
    

    Api.Comment.postReaction(
      reactionDict: reactionDict,
      comment: comment
    ) {
      
    }
  }
  
  func handleReactionTap(reaction: Reaction, comment: Comment) {
    Haptic.impact(type: "soft")
    guard let userId = Auth.auth().currentUser?.uid else { return }
    var userReaction = self.reactions.filter { $0.reactorId == userId && $0.emojiCode == reaction.emojiCode }
    if userReaction.isEmpty{
      addReaction(reaction.emojiCode, comment)
    } else {
      removeReaction(reaction, comment)
    }
    
  }
}
