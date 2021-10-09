//
//  EmojiKeyboard.swift
//  wingit4
//
//  Created by Joshua Lee on 9/29/21.
//

import SwiftUI



struct EmojiKeyboard: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
      
//      ForEach(self.words.filter({ $0.contains(self.searchText.lowercased()) || self.searchText.isEmpty}), id: \.self) { word in
//                         Text(word)
//                             .font(.title)
//                             .padding([.leading, .bottom])
//                             .frame(maxWidth: .infinity, alignment: .leading)
//                     }
    
      ScrollView(showsIndicators: false) {
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(Emojis.orderedEmojiHexList.filter({ UnicodeScalar($0)?.properties.name!.lowercased().contains(commentSheetViewModel.searchText.lowercased()) as! Bool || commentSheetViewModel.searchText.isEmpty }), id: \.self) { i in
            Button(action: {}) {
                Text(String(UnicodeScalar(i)!))
                  .font(.system(size: 30))
                
//                Text((UnicodeScalar(i)?.properties.name ?? ""))
//              }

            }
          }
        }
        .animation(.default)

      }
      .frame(
        width: UIScreen.main.bounds.width
      )
    }
}
