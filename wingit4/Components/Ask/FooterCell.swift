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
    
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          HStack {
            LikeButton(
              post: $post,
              showLabel: true
            )
            Spacer()
            ReferButton(post: $post)
            Spacer()
            CommentButton(
              showLabel: true
            )
            Spacer()
            ShareButton(
              post: $post,
              showLabel: true
            )
          }
        }
        .padding(.bottom, 15)
        .frame(maxWidth: .infinity)
        .environmentObject(footerCellViewModel)
    }
}


