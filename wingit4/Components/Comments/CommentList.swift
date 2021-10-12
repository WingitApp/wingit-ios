//
//  CommentList.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct CommentList: View {
  @EnvironmentObject var commentViewModel : CommentViewModel
  @Binding var post: Post?
  
    var body: some View {
        if !commentViewModel.comments.isEmpty {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(commentViewModel.comments.enumerated()), id: \.element) { index, comment in
                UserComment(
                  comment: comment,
                  post: post,
                  postOwnerId: post?.ownerId
                )
                  .id(index)
                  .frame(width: UIScreen.main.bounds.width)

            }
          }
          .background(Color.white)
        }
    }
}
