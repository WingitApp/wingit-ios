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
      .foregroundColor(Color.gray)
  }
}

struct ConnectionNotifButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, 10)
      .frame(
        width: ((UIScreen.main.bounds.width - 40) / 2) - 30,
        height: UIScreen.main.bounds.width / 11
      )
      .cornerRadius(5)
  }
}

struct CardStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.borderGray, lineWidth: 1)
      )
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
      )
  }
}

struct UserAvatarStyle: ViewModifier {
  var index: Int = 0
  
  func body(content: Content) -> some View {
    content
    .clipShape(Circle())
    .overlay(
      RoundedRectangle(cornerRadius: 100)
        .stroke(Color.gray, lineWidth: 1)
    )
    .padding(.leading, index > 0 ? -15 : 0)
  }
}

struct RoundBorderStyle: ViewModifier {
  var color: Color
  var lineWidth: CGFloat = 1
  
  func body(content: Content) -> some View {
    content
      .overlay(
        RoundedRectangle(cornerRadius: 100)
          .stroke(color, lineWidth: lineWidth)
      )
  }
}

//struct LabelTagStyle: TextModi {
//  var textColor: Color
//  var backgroundColor: Color
//  
//  func body(content: Text) -> some View {
//    content
//      .bold()
//      .kerning(1)
//      .font(.system(size: 9))
//      .foregroundColor(textColor)
//      .padding(
//        EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
//      )
//      .background(backgroundColor)
//      .cornerRadius(5)
//      .overlay(RoundedRectangle(cornerRadius: 5)
//                .stroke(backgroundColor.darker(by: 4), lineWidth: 1))
//      .clipped()
//      .shadow(color: backgroundColor.opacity(0.5), radius: 2, x: 0, y: 0)
//  }
//}
