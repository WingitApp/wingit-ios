//
//  AskCardTag.swift
//  wingit4
//
//  Created by Joshua Lee on 9/27/21.
//

import SwiftUI

struct AskCardTag: View {
  var post: Post?
  
  func getStatus() -> String {
      guard let post = post else { return "" }
    let status =  post.type?.rawValue ?? ""
    if status.isEmpty {
      return "general".uppercased()
    }
    return post.type!.rawValue.uppercased()
  }
  
  func textColor() -> Color {
    let status = post?.type?.rawValue ?? ""
    
    switch(status) {
      case "recommendations":
        return Color.uiviolet
      case "advice":
        return Color.uiblue
      case "assistance":
        return Color.uiorange
      case "general":
        return Color.uigreen
      default:
        return Color.uigreen
    }
  }
  
  
  func backgroundColor() -> Color {
    let status = post?.type?.rawValue ?? ""

  
    switch(status) {
      case "recommendations":
        return Color.uilightViolet
      case "advice":
        return Color.uilightBlue
      case "assistance":
        return Color.uilightOrange
      case "general":
        return Color.uilightGreen
      default:
        return Color.uilightGreen
    }
  }
  
    var body: some View {
      Text(getStatus())
        .fontWeight(.heavy)
        .kerning(1)
        .font(.system(size: 9))
        .foregroundColor(textColor())
        .padding(
          EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        )
        .background(backgroundColor())
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
                  .stroke(backgroundColor().darker(by: 4), lineWidth: 1))
        .clipped()
        .shadow(color: backgroundColor().darker(by: 4).opacity(0.5), radius: 2, x: 0, y: 0)
    }
}

