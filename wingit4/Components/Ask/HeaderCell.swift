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
  
  func textByIndex(index: Int) -> String {
    let modIndex = index % 4
    
    switch(modIndex) {
      case 0:
        return "Physical"
      case 1:
        return "Question"
      case 2:
        return "Recommendation"
      case 3:
        return "Advice"
      default:
        return ""
    }
  }
  
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
  
  func secondaryColorByIndex(index: Int) -> Color {
    let modIndex = index % 4
    
    switch(modIndex) {
      case 0:
        return Color.uilightViolet
      case 1:
        return Color.uilightBlue
      case 2:
        return Color.uilightGreen
      case 3:
        return Color.uilightOrange
      default:
        return Color.white
    }
  }
  
  
  
  
  
    var body: some View {
        VStack {
            HStack {
              Text(textByIndex(index: index!).uppercased())
                .fontWeight(.heavy)
                .kerning(1)
//                .font(.footnote)
                .font(.system(size: 9))
                .foregroundColor(primaryColorByIndex(index: index!))
                .padding(
                  EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
                )
                .background(secondaryColorByIndex(index: index!))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5)
                          .stroke(secondaryColorByIndex(index: index!).darker(by: 4), lineWidth: 1))
                .clipped()
                .shadow(color: secondaryColorByIndex(index: index!).darker(by: 4).opacity(0.5), radius: 2, x: 0, y: 0)
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
