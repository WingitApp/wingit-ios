//
//  Styles.swift
//  wingit4
//
//  Created by Joshua Lee on 9/7/21.
//

import SwiftUI

struct ActionIconStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.leading, 15)
  }
}


struct CircleDotStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: 2, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .foregroundColor(.gray)
  
  }
}

struct FeedItemShadow: ViewModifier {
  func body(content: Content) -> some View {
    content
      .clipped()
      .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
  }
}

struct IconButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.gray)
  }
}

