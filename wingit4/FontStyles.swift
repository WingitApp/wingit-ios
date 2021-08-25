//
//  FontStyles.swift
//  wingit4
//
//  Created by Joshua Lee on 8/18/21.
//

import SwiftUI

/**********************************
 *        TEXT STYLES             *
 **********************************/
 

struct Header1: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
  }
}

struct Header2: ViewModifier {
  func body(content: Content) -> some View {
    content
  }
}

struct FootNote: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.footnote).foregroundColor(.gray)
  }
}

struct BodyStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
  }
}

struct TimeStampStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
    
  }
}

struct TextStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
  }
}


struct LinkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.caption).foregroundColor(.blue)
    }
}

struct CaptionStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.caption).foregroundColor(.gray)
  }
}

struct Caption2Style: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.caption2).foregroundColor(.gray)
  }
}

struct UserNameStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.subheadline)
//      .bold()
  }
}

struct ActionIconStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.trailing, 15).padding(.leading, 15)
  }
}
