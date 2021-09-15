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
          ReferButton(
            post: $post,
            showLabel: true
          )
          .padding(.leading, 15)
          Spacer()
          CommentButton(
            showLabel: true,
            isTapDisabled: true
          )
          Spacer()
          ShareButton(
            post: $post,
            showLabel: true
          )
        }
        .padding(
          EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 15)
        )
        Divider()
      }
  
    }
}
