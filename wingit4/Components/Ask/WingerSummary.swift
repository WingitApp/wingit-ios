//
//  WingerSummary.swift
//  wingit4
//
//  Created by Joshua Lee on 9/17/21.
//

import SwiftUI

struct WingerCountSummary: View {
  @Binding var wingers: [User]
  var limit: Int = 3
  var size: CGFloat = 25
  
  func primaryColorByIndex(index: Int) -> Color {
    let modIndex = index % 4
    
    switch(modIndex) {
      case 0:
        return Color.uiviolet
      case 1:
        return Color.uiblue
      case 2:
        return Color.uigreen
      case 3:
        return Color.uiorange
      default:
        return Color.white
    }
  }
  
  func getPaddingByIndex(index: Int) -> CGFloat {
    return index > 0 ? -15 : 0
  }
  
  func formatDescription() -> Text? {
    let remainder = wingers.count - limit
    return remainder > 0
      ? Text("+ \(remainder)")
        .fontWeight(.semibold)
        .font(.caption)
      : nil
    
  }
  
    var body: some View {
      HStack {
        ForEach(Array(wingers.prefix(limit).enumerated()), id: \.element) { index, winger in
          UserAvatar(
            user: winger,
            height: size,
            width: size
          )
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
          .padding(.leading, getPaddingByIndex(index: index))
          
        }
//        formatDescription()
        WingerTextDescription.getFormattedString(
          wingers: wingers,
          limit: WingersRow.WINGER_DISPLAY_LIMIT
        )
        .font(.caption2)
    }
  }
}
