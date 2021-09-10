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
      HStack(alignment: .top, spacing: 0) {
        URLImage(URL(string: session.currentUser!.profileImageUrl!)!,
              content: {
                  $0.image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .clipShape(Circle())
              }).frame(width: 35, height: 35)
              .overlay(
                RoundedRectangle(cornerRadius: 100)
                  .stroke(Color.gray, lineWidth: 1)
              )
          .padding(.trailing, 10)
              
        HStack(alignment: .top){
             TextView("Add a comment", text: $composedMessage)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.gray, lineWidth: 1)
              )
             Button(action: onCommentSubmit) {
                 Image(systemName: "paperplane.fill")
                  .font(.system(size:20))
                  .foregroundColor(Color(.systemTeal))
             }
             .padding(.top, 8)
         }
      }
      .padding(
        EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10)
      )
        
//      .frame(maxHeight: 200)
 
     
    }
}
