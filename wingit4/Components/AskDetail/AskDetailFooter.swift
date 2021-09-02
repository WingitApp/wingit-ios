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
  @StateObject var footerCellViewModel = FooterCellViewModel()
  @StateObject var shareButtonViewModel = ShareButtonViewModel()


    var body: some View {
      Divider()
      HStack {
        LikeButton(post: $post)
          .font(.system(size: 25))
        CommentButton()
          .font(.system(size: 20))

        Spacer()
        ShareButton(post: $post)
      }
      .environmentObject(footerCellViewModel)
      .padding(.leading, 15)
      .padding(.trailing, 15)
      Divider()
    }
}
