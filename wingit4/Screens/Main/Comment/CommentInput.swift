//
//  CommentInput.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage


struct CommentInput: View {
  // VM
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var commentViewModel: CommentViewModel
    @EnvironmentObject var commentInputViewModel: CommentInputViewModel
  
  // Props & State
    @Binding var post: Post
    @State var composedMessage: String = ""
  
  
    func onCommentSubmit() {
      if !composedMessage.isEmpty {
        self.commentInputViewModel.saveComment(
            text: composedMessage,
            post: post
          ) { comment in
            self.composedMessage = ""
          }
      } else {
        //TODO: show feedback message
      }
    }
  
    
    var body: some View {
      VStack() {

        Divider()
        HStack(alignment: .bottom){
             TextView("Write a response", text: $composedMessage)
             Button(action: onCommentSubmit) {
                 Image(systemName: "arrow.up.circle.fill")
                  .font(.system(size:23))
                  .foregroundColor(.wingitBlue)
             }
             .padding(.top, 8)
         }
        .padding(
          EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10)
        )
      }

     
    }
}
