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
        // todo: like count
        Text("Like")
          .font(.caption)
//          .font(.system(size: 25))
        Spacer()
        CommentButton()
          .font(.system(size: 15))
          .padding(.leading, -15)
        Text("Comment")
          .font(.caption)

        Spacer()
        ShareButton(post: $post)
          .padding(.trailing, -15)

        Text("Share")
          .font(.caption)
      }
      .environmentObject(footerCellViewModel)
      .padding(
        EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 15)
      )
      Divider()
    }
}
