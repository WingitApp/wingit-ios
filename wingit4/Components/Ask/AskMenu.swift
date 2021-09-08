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


    var body: some View {
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
//          Button(
//            action: self.askMenuViewModel.onTapBlockUser
//          ) {
//              Text("Block")
//          }
        }, label: {
          Image(systemName: "ellipsis")
            .rotationEffect(.degrees(-90))
            .foregroundColor(.white)
        })
      } else {
        Menu(content: {
          Button(
            action: self.askCardViewModel.removePost
          ) {
              Text("Delete")
          }
        }, label: {
          Image(systemName: "ellipsis")
            .rotationEffect(.degrees(-90))
            .foregroundColor(.white)
        })
      }
   }
}
