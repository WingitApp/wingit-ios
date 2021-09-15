//
//  CommentButton.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI

struct CommentButton: View {
  @EnvironmentObject var commentViewModel: CommentViewModel
  var showLabel: Bool = false
  var isTapDisabled: Bool = false
  
  func onTapCommentIcon() {
    if !isTapDisabled {
      logToAmplitude(event: .viewComments)
      self.commentViewModel.toggleCommentScreen()
    }
  }
  
  var body: some View {

    Button(
      action: onTapCommentIcon,
      label: {
        Text("\(commentViewModel.comments.count.formatUsingAbbrevation())")
          .font(.caption)
          .opacity(self.commentViewModel.comments.isEmpty ? 0 : 1)
        Text(
          Image(systemName: "message")
        )
        .fontWeight(.light)
        .modifier(IconButtonStyle())

        if self.showLabel {
          Text("Comment")
            .font(.caption)
            .font(.system(size: 15))
        }
      })
      .buttonStyle(PlainButtonStyle())
     
  }
    
}
