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
            ForEach(commentViewModel.comments) { comment in
              if comment.type != .invitedReferral {
                UserComment(comment: comment, postOwnerId: post.ownerId)
              }
            }
          }
          .background(Color.white)
        }
    }
}
