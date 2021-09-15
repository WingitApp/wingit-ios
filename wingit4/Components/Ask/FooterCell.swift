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
            ReferButton(
              post: $post,
              showLabel: true
            )
            .frame(width: (UIScreen.main.bounds.width - 30) / 3)
            Spacer()
            CommentButton(
              showLabel: true
            )
            .frame(width: (UIScreen.main.bounds.width - 30) / 3)
            Spacer()
            ShareButton(
              post: $post,
              showLabel: true
            )
            .frame(width: (UIScreen.main.bounds.width - 30) / 3)
          }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .padding(.bottom, 15)
      .frame(maxWidth: UIScreen.main.bounds.width - 30)
    }
}
