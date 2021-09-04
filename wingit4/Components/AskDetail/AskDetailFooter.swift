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
        Text("Like")
          .font(.caption)
//          .padding(.leading, 15)
//          .font(.system(size: 25))
//        CommentButton()
        
//          .font(.system(size: 20))

        Spacer()
        ShareButton(post: $post)
      }
      .environmentObject(footerCellViewModel)
      .padding(
        EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 15)
      )
      Divider()
    }
}
