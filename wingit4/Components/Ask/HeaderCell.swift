//
//  HeaderCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct HeaderCell: View {
  
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post
  var index: Int?
  
  func getStatus() -> String {
    let status =  post.type?.rawValue ?? ""
    if status.isEmpty {
      return "general".uppercased()
    }
    return post.type!.rawValue.uppercased()
  }
  
  func textColor() -> Color {
    let status = post.type?.rawValue ?? ""
    
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
    let status = post.type?.rawValue ?? ""

  
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
        VStack {
            HStack {
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
              Spacer()
              if askCardViewModel.isProfileView {
                AskDoneToggle(post: $post) // rename later
              }
                AskMenu()
            }
            .padding(
              EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
            )
        }
    }
}
