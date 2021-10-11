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
  
  func convertToHex(num: Int) -> String{
    let emoji = String(UnicodeScalar(num)!)
    let uni = emoji.unicodeScalars // Unicode scalar values of the string
    let unicode = uni[uni.startIndex].value // First element as an UInt32
    return String(unicode, radix: 16, uppercase: true)
  }
  
  func filterableEmojis() -> [Int] {
    return Emojis.emojiHexShortList.filter({ UnicodeScalar($0)?.properties.name!.lowercased().contains(commentSheetViewModel.searchText.lowercased()) as! Bool || commentSheetViewModel.searchText.isEmpty
    })
  }

    var body: some View {
    
      ScrollView(showsIndicators: false) {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(filterableEmojis(), id: \.self) { i in
              Button(action: {}) {
                VStack {
                  Text(String(UnicodeScalar(i)!))
                    .font(.system(size: 30))
//                  Text((UnicodeScalar(i)?.properties.name ?? ""))
//                    .font(.system(size: 10))
                }
              }
            }
      }
      .frame(
        width: UIScreen.main.bounds.width
      )
    }
    }
}

//
//struct EmojiKeyboard_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiKeyboard()
//    }
//}
