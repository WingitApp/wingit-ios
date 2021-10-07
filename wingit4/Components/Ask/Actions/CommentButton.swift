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
      Haptic.impact(type: "soft")
      self.commentViewModel.toggleCommentScreen()
    } else {
      self.commentViewModel.isTextFieldFocused = true
//      .becomeFirstResponder()
    }
  }
  
  var body: some View {
    Button(
      action: onTapCommentIcon,
      label: {
          Text(
            Image(systemName: "message")
          )
          .fontWeight(.light)
          .modifier(IconButtonStyle())
//          if self.commentViewModel.isLoading {
//            CircleLoader()
//          }
          if self.commentViewModel.comments.count > 0 {
            Text("\(commentViewModel.comments.count.formatUsingAbbrevation())")
              .foregroundColor(Color.wingitBlue)
              .font(.caption)
          }
        if self.showLabel {
          Text("Comment")
            .font(.caption)
            .font(.system(size: 15))
        }
      })
      .buttonStyle(PlainButtonStyle())
      .redacted(reason: self.commentViewModel.isLoading ? /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/ : [])
  }
    
}
