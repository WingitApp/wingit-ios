//
//  EmojiKeyboard.swift
//  wingit4
//
//  Created by Joshua Lee on 9/29/21.
//

import SwiftUI

struct EmojiKeyboard: View {
//  private var emoji
  
  private let columns = [
          GridItem(.flexible()),
          GridItem(.flexible()),
          GridItem(.flexible()),
          GridItem(.flexible()),
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
  
    var body: some View {
      ScrollView(showsIndicators: false) {
        LazyVGrid(columns: columns, spacing: 10) {
          ForEach(Emojis.orderedEmojiHexList, id: \.self) { i in
            Button(action: {}) {
              VStack {
                Text(String(UnicodeScalar(i)!))
                  .font(.system(size: 30))
              }

            }
          }
        }
      }
      .frame(maxHeight: 500)
      .frame(
        width: UIScreen.main.bounds.width
//        height: UIScreen.main.bounds.height
      )
      .background(Color.white)
    }
}

struct EmojiKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        EmojiKeyboard()
    }
}
