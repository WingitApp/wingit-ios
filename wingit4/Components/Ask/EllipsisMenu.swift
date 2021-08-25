//
//  DropDownMenu.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import SwiftUI

struct EllipsisMenu: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @ObservedObject var ellipsisMenuViewModel = EllipsisMenuViewModel()


    var body: some View {
      if askCardViewModel.isOwnPost {
        Menu(content: {
          Button(
            action: ellipsisMenuViewModel.onTapHidePost
          ) {
              Text("Hide Post")
          }
          Button(
            action: ellipsisMenuViewModel.onTapOpenReportScreen
          ) {
              Text("Report")
          }
          Button(
            action: ellipsisMenuViewModel.onTapBlockUser
          ) {
              Text("Block")
          }
        }, label: {
          Image(systemName: "ellipsis")
        })
      } else {
        Menu(content: {
          Button(
            action: askCardViewModel.removePost
          ) {
              Text("Delete")
          }
        }, label: {
          Image(systemName: "ellipsis")
        })
      }
   }
}
