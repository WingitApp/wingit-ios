//
//  CommentSheetHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 10/9/21.
//

import SwiftUI

struct CommentSheetHeader: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel

  let laughingEmoji = 0x1F606
  let heartEmoji = 0x2764
  let thumbsUpEmoji = 0x1F44D
  let thankEmoji = 0x1F64F
  let smileEmoji = 0x1F642
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        if commentSheetViewModel.isEmojiKeyboardActive {
          HStack(alignment: .center){
            Button(action: commentSheetViewModel.toggleEmojiKeyboard) {
              Image(systemName: "chevron.backward")
                  .imageScale(.large)
                  .foregroundColor(.gray)
            }
            SearchBar(
              text: $commentSheetViewModel.searchText,
              placeholder: "Search for emojis"
            )
          }
          .padding(.horizontal)
          .padding(.top, 5)
          .padding(.bottom, 10)
        } else {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: (UIScreen.main.bounds.width - 240) / 6) {
              EmojiHeaderButton(emojiCode: thumbsUpEmoji)

              EmojiHeaderButton(emojiCode: heartEmoji)

              EmojiHeaderButton(emojiCode: smileEmoji)

              EmojiHeaderButton(emojiCode: thankEmoji)

              EmojiHeaderButton(emojiCode: laughingEmoji)
              
              Button(action: commentSheetViewModel.toggleEmojiKeyboard) {
                Text(Image(systemName: "plus"))
                  .foregroundColor(.gray)
                  .font(.system(size: 23))
                  .clipShape(Circle())
                  .frame(width: 40, height: 40, alignment: .center)
                  .background(BlurView())
                  .cornerRadius(100)
              }
              .buttonStyle(PlainButtonStyle())
             
            }
            .padding(.horizontal)
            .padding(.top, 5)
            .padding(.bottom, 10)
          }
          .frame(width: UIScreen.main.bounds.width)
        }
    
        Divider()
      }
      .frame(width: UIScreen.main.bounds.width)
      .environmentObject(commentSheetViewModel)
    }
}
