//
//  FooterCell.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//
import SwiftUI
import URLImage

struct FooterCell: View {
  @Binding var post: Post
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var footerCellViewModel: FooterCellViewModel
  
  @StateObject var shareButtonViewModel = ShareButtonViewModel()
    
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
          HStack {
            LikeButton(post: $post)
            CommentButton()
            Spacer()
            ReferButton(post: $post)
            ShareButton(post: $post)
          }
        }
        .padding(.trailing, 15)
        .padding(.bottom, 15)
        .frame(maxWidth: .infinity)
    }
}
