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
  
//  func makeDictionary
  
  func fetchReactions(comment: Comment) {
    print("fetch reactions called")
    isFetchingReactions = true
    self.reactions = []
    Api.Comment.getReactionsByComment(
      comment: comment,
      onEmpty: {
        self.isFetchingReactions = false
        print("fetch reactions empty")
      },
      onSuccess: { reactions in
        if self.reactions.count >= reactions.count { return }
        self.reactions = reactions
        self.isFetchingReactions = false
        print("fetch reactions success:", reactions)

      },
      newReaction: { reaction in
        print("new reaction called")
        if self.reactions.contains(reaction) { return }
        self.reactions.append(reaction)
        print("new reaction:", reaction)

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
}
