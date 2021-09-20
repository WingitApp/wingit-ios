//
//  AskDetailFooter.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailFooter: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  @StateObject var shareButtonViewModel = ShareButtonViewModel()


    var body: some View {
      VStack {
        Divider()
        HStack {
          Spacer()
          CommentButton(
            isTapDisabled: true
          )
          ReferButton(
            post: $post
          )
        }
        .padding(
          EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 15)
        )
        .frame(height: 30)
        Divider()
      }
  
    }
}
