//
//  Reaction.swift
//  wingit4
//
//  Created by Joshua Lee on 10/11/21.
//

import SwiftUI

struct ReactionButton: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var reactionBarViewModel: ReactionBarViewModel
    var reaction: Reaction
    var comment: Comment

    
    func loadReactionBar() {
      reactionBarViewModel.fetchReactions(comment: comment)
    }
    
    func removeListener() {
      guard let listener = self.reactionBarViewModel.listener else { return }
      listener.remove()
    }
  
  func onTapAction() {
    reactionBarViewModel.handleReactionTap(
      reaction: reaction,
      comment: comment,
      currentUser: session.currentUser
    )
  }
    
    var body: some View {
      Button(action: onTapAction) {
        HStack(alignment: .center, spacing: 5){
          Text(String(UnicodeScalar(reaction.emojiCode)!))
            .font(.system(size: 13))
          Text(String(reaction.count))
            .font(.system(size: 12))
        }
        .padding(3)
        .background(reaction.hasCurrentUser
          ? Color.backgroundBlueGray
          : Color.lightGray
        )
        .cornerRadius(5)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(reaction.hasCurrentUser
                    ? Color.twitterBlue.opacity(0.5)
                    : Color.lightGray.darker(by: 5), lineWidth: 1)
        )

      }
      .buttonStyle(PlainButtonStyle())
      
    }
}
