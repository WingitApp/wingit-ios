//
//  CommentButton.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI

struct CommentButton: View {
  @EnvironmentObject var commentViewModel: CommentViewModel
  
  func onTapCommentIcon() {
    logToAmplitude(event: .viewComments)
    self.commentViewModel.toggleCommentScreen()
  }
  
  var body: some View {
    Button(
      action: onTapCommentIcon,
      label: {
          Image(systemName: "message")
            .foregroundColor(.gray)
            .padding(.leading, 10)
            .accentColor(.red)
      })
//    if !self.commentViewModel.comments.isEmpty {
//      Text("\(commentViewModel.comments.count)")
//        .modifier(CaptionStyle())
//    }
  }
    
}
