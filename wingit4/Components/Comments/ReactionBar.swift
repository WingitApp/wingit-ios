//
//  ReactionBar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

let smile = Reaction(
  emoji: "😀",
  commentId: "placeholder",
  reactorId: "aujRk5mmQPc2c5lCeI30DYs7fg52",
  avatarUrl: "https://firebasestorage.googleapis.com:443/v0/b/wingitapp-1fe28.appspot.com/o/avatar%2FaujRk5mmQPc2c5lCeI30DYs7fg52?alt=media&token=f083a9ac-2b0a-40a2-8794-df7c0b9b8533",
  username: "joshslee",
  score: .positive
)

struct ReactionBar: View {
  
  // emoji

  @State var text: String = ""
  @State var showSheet: Bool = false
  var emojiList: [Reaction] = [smile]
  
    var body: some View {
      HStack {
        ForEach(Array(self.emojiList.enumerated()), id: \.element) { index, reaction in
          HStack(alignment: .center, spacing: 3){
            Text("\(reaction.emoji)")
              .font(.system(size: 13))
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
        
        Image(systemName: "plus")
          .padding(3)
          .background(Color.lightGray)
          .cornerRadius(100)
          .font(.system(size: 13))
        
//            EmojiTextField(text: $text, placeholder: "Enter emoji")


      }
      
    }
}
