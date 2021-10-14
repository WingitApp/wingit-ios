//
//  UserCommentText.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct CommentText: View {
  var comment: Comment
  
  var body: some View {
    HStack {
      Text(comment.comment?.trim() ?? "")
        .font(.callout)
      +
      Text("\((comment.isEdited ?? false) ? " (edited)" : "")")
        .foregroundColor(Color.gray)
        .font(.system(size: 13))
    }
    .fixedSize(horizontal: false, vertical: true)
    .padding(.top, 1)
  }
}
