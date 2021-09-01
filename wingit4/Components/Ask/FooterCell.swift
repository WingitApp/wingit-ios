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
            LikeButton(post: $post)
            CommentButton()
            Spacer()
            ReferButton()
            ShareButton(post: $post)
          }
        }
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
        .environmentObject(footerCellViewModel)
    }
}


