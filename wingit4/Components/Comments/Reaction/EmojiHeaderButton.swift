//
//  EmojiHeaderButton.swift
//  wingit4
//
//  Created by Joshua Lee on 10/9/21.
//

import SwiftUI

struct EmojiHeaderButton: View {
    @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel

    var emojiCode: Int
  
    func onTapGesture() {
      print("emoji header button tapped")
      commentSheetViewModel.addReaction(emojiCode: emojiCode)
    }
  
    var body: some View {
      Button(action: onTapGesture) {
        Text(String(UnicodeScalar(emojiCode)!))
          .font(.system(size: 25))
          .clipShape(Circle())
          .frame(width: 40, height: 40, alignment: .center)
          .background(BlurView())
          .cornerRadius(100)
//          .overlay(
//            RoundedRectangle(cornerRadius: 100)
//              .stroke(Color.gray, lineWidth: 1)
//          )
        
        
      }
    }
}

