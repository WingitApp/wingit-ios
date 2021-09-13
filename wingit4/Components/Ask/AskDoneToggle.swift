//
//  DoneToggle.swift
//  wingit4
//
//  Created by Joshua Lee on 8/24/21.
//

import SwiftUI

struct AskDoneToggle: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Binding var post: Post
  
    var body: some View {
      
      if askCardViewModel.isOwnPost {
        Button(
          action: {
            askCardViewModel.openCloseToggle(post: post)
          },
          label: {
            Image(systemName: "checkmark.circle")
              .foregroundColor(self.post.status == .closed ? Color("Color1") : Color.gray)
              }
            )
      }
    }
}

