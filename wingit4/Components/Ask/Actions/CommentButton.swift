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
  
  func onTapCommentIcon() {
    logToAmplitude(event: .viewComments)
    self.commentViewModel.toggleCommentScreen()
  }
  
  var body: some View {

    Button(
      action: onTapCommentIcon,
      label: {
          Image(systemName: "message")
            .modifier(IconButtonStyle())
//            .padding(.leading, 10)
            .accentColor(.red)
      })
      Text("\(commentViewModel.comments.count.formatUsingAbbrevation())")
        .modifier(CaptionStyle())
        .opacity(self.commentViewModel.comments.isEmpty ? 0 : 1)
    if self.showLabel {
      Text("Comment")
        .font(.caption)
        .font(.system(size: 15))
        // todo: do this conditionaly

    }
  }
    
}
