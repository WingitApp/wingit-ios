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
  var scrollProxyValue: ScrollViewProxy?
  
  var body: some View {
    if !commentViewModel.comments.isEmpty {
      VStack(alignment: .leading, spacing: 0) {
        ForEach(Array(commentViewModel.comments.enumerated()), id: \.element) { index, comment in
          UserComment(
            comment: comment,
            post: post,
            index: index,
            scrollProxyValue: scrollProxyValue
          )
            .id(index)
            .frame(width: UIScreen.main.bounds.width)
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
        }
      }
      .background(Color.white)
    }
  }
}
