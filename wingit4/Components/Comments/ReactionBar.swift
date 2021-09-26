//
//  ReactionBar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

struct ReactionBar: View {
  
  // emoji
  @State var text: String = ""
  var emojiList: [String] = ["😀", "🦄"]
  
    var body: some View {
      HStack {
        ForEach(self.emojiList.indices, id: \.self) { index in
          HStack(alignment: .center){
            Text("\(self.emojiList[index])")
              .font(.system(size: 13))

            Text("3")
              .font(.caption)
              .font(.system(size: 10))
          }
          .padding(3)
          .background(Color.lightGray)
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

struct ReactionBar_Previews: PreviewProvider {
    static var previews: some View {
        ReactionBar()
    }
}
