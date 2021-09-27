//
//  DropDownMenu.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import SwiftUI

struct AskMenu: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var askMenuViewModel: AskMenuViewModel
  var isHorizontal: Bool = false

    var body: some View {
        VStack{
      if !self.askCardViewModel.isOwnPost {
        
        Menu(content: {
          Button(
            action: self.askCardViewModel.hidePost
          ) {
              Text("Hide Post")
          }
          Button(
            action: self.askMenuViewModel.onTapOpenReportScreen
          ) {
              Text("Report")
          }
          Button(
            action: self.askCardViewModel.onTapBlockUser
          ) {
              Text("Block")
          }
        }, label: {
            EllipsisButton(isHorizontal: isHorizontal)
        })
       
      }
//      else {
//        Menu(content: {
//          Button(
//            action: self.askCardViewModel.removePost
//          ) {
//              Text("Delete")
//          }
//        }, label: {
//          EllipsisButton()
//        })
//      }
        }
   }
}

struct EllipsisButton: View {
  
    var isHorizontal: Bool = false
    var body: some View {
        ZStack{
          Image(systemName: "ellipsis")
            .rotationEffect(.degrees(isHorizontal ? 0 : -90))
            .foregroundColor(.wingitBlue)
          }
      }
}
