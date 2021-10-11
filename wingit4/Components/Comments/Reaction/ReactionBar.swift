//
//  ReactionBar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

struct ReactionBar: View {
  @EnvironmentObject var reactionBarViewModel: ReactionBarViewModel
  
  var comment: Comment
  @State var text: String = ""
  @State var showSheet: Bool = false
  
  func loadReactionBar() {
    print("load reaction called")
    reactionBarViewModel.fetchReactions(comment: comment)
    print("reactions:", self.reactionBarViewModel.reactions)
  }
  
  func removeListener() {
    print("disappear")
    guard let listener = self.reactionBarViewModel.listener else { return }
    listener.remove()
  }
  
  func handleTap(reaction: Reaction) {
    
  }
  
    var body: some View {
      HStack {
        ForEach(Array(self.reactionBarViewModel.reactions.enumerated()), id: \.element) { index, reaction in
          Button(action: { handleTap(reaction: reaction)} ) {
            HStack(alignment: .center, spacing: 3){
              Text(String(UnicodeScalar(reaction.emojiCode)!))
                .font(.system(size: 15))
              Text("3")
                .font(.caption)
                .font(.system(size: 10))
            }
            .padding(3)
            .background(reaction.isOwn!
              ? Color.backgroundBlueGray
              : Color.lightGray
            )
            .cornerRadius(5)

          }
          .buttonStyle(PlainButtonStyle())
        }
        
        if !self.reactionBarViewModel.reactions.isEmpty {
          Image(systemName: "plus")
            .padding(3)
            .background(Color.lightGray)
            .cornerRadius(100)
            .font(.system(size: 13))
        }
       
      }
      .onAppear(perform: loadReactionBar)
      .onDisappear(perform: removeListener)
      
    }
}
