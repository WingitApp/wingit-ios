//
//  FooterCellNew.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI
import URLImage

struct FooterCell: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @StateObject var footerCellViewModel = FooterCellViewModel()
  @StateObject var shareButtonViewModel = ShareButtonViewModel()
  @StateObject var commentViewModel = CommentViewModel()
    
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          HStack {
            LikeButton(post: $post)
            CommentButton()
            Spacer()
            ShareButton(post: $post)
          }
          RecButton()
            .modifier(ActionIconStyle())
          Divider()
        }
        .frame(maxWidth: .infinity)
        .environmentObject(footerCellViewModel)
        .environmentObject(commentViewModel)
        .sheet(
          isPresented: $commentViewModel.isCommentSheetShown,
          content: { CommentView(post: $post) }
        )

    }
}


