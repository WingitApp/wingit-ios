//
//  CommentList.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct CommentList: View {
  @EnvironmentObject var commentViewModel : CommentViewModel
  @Binding var post: Post
  
    var body: some View {
        if !commentViewModel.comments.isEmpty {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(commentViewModel.comments.indices, id: \.self) { index in
                UserComment(
                  comment: commentViewModel.comments[index],
                  postOwnerId: post.ownerId
                )
                  .id(index)
            }
          }
          .background(Color.white)
        }
    }
}
