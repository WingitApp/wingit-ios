//
//  PostTypeOption.swift
//  wingit4
//
//  Created by Joshua Lee on 9/21/21.
//

import SwiftUI

struct PostTypeOption: View {
  var option: String?
  
  func primaryColor() -> Color {
      
    switch(option) {
      case "recommendations":
        return Color.uiviolet
      case "advice":
        return Color.uiblue
      case "assistance":
        return Color.uigreen
      case "general":
        return Color.uiorange
      default:
        return Color.uiviolet
    }
  }
  
  
    var body: some View {
      Text(option!.uppercased())
        .fontWeight(.heavy)
        .kerning(1)
        .font(.system(size: 10.5))
        .foregroundColor(primaryColor().darker(by: 4))
        .padding(.top, 12)
        .padding(.bottom, 12)
    }
}
