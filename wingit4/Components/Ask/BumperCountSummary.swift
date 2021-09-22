//
//  BumperCountSummary.swift
//  wingit4
//
//  Created by Joshua Lee on 9/18/21.
//


import SwiftUI

struct BumperCountSummary: View {
  var users: [User]
  var limit: Int = 3
  var size: CGFloat = 25
  var showDescription: Bool = false
  
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
    let remainder = users.count - limit
    return remainder > 0
      ? Text("+ \(remainder)")
        .fontWeight(.semibold)
        .font(.caption)
      : nil
    
  }
  
    var body: some View {
      HStack {
        ForEach(Array(users.prefix(limit).enumerated()), id: \.element) { index, bumper in
          UserAvatar(
            user: bumper,
            height: size,
            width: size
          )
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.white, lineWidth: 1)
          )
          .padding(.leading, getPaddingByIndex(index: index))
          
        }
        if showDescription {
          BumpersTextDescription.getFormattedString(
            bumpers: users,
            limit: limit,
            emptyMessage: nil
          )
          .font(.caption2)

        } else {
          BumpersTextDescription.getFormattedCount(
            users: users,
            limit: limit,
            emptyMessage: nil
          )
          .font(.caption2)
        }
       
    }
  }
}
