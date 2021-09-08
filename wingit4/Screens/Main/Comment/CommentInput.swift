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
        HStack(spacing: 0) {
            URLImageView(inputURL: session.currentUser?.profileImageUrl)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 50, height: 50)
                .padding(.leading, 15)
            ZStack {
                 RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                 HStack {
                     TextField("Add a comment", text: $composedMessage).padding(30)
                     Button(action: commentAction) {
                         Image(systemName: "arrow.right.circle").imageScale(.large).foregroundColor(.black).padding(30)
                     }
                 }

             }.frame(height: 70)
        }
//      .frame(maxHeight: 200)

 
     
    }
}
