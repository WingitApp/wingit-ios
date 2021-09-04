//
//  CommentInput.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

struct CommentInput: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentInputViewModel = CommentInputViewModel()

    @Binding var post: Post
    
    @State var composedMessage: String = ""
    
    func handleInputViewModel() {
      Api.Post.loadPost(postId: post.postId) { (post) in
            self.commentInputViewModel.post = post
        }
    }
    
    func commentAction() {
        if !composedMessage.isEmpty {
            commentInputViewModel.addComments(text: composedMessage) {
                self.composedMessage = ""
            }
        }
    }
    
    var body: some View {
      Divider()
      HStack(alignment: .top, spacing: 0) {
            URLImage(URL(string: session.currentUser!.profileImageUrl)!,
              content: {
                  $0.image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .clipShape(Circle())
              }).frame(width: 30, height: 30
            )
              .overlay(
                RoundedRectangle(cornerRadius: 100)
                  .stroke(Color.gray, lineWidth: 1)
              )
              .padding(
                EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 15)
              )
              
        HStack(alignment: .top){
             TextView("Add a comment", text: $composedMessage)
              .overlay(
                RoundedRectangle(cornerRadius: 20)
                  .stroke(Color.gray, lineWidth: 1)
              )
              .padding(.top, 15)
             Button(action: commentAction) {
                 Image(systemName: "paperplane.fill")
//                  .imageScale(.large)
                  .font(.system(size:18))
                  .foregroundColor(Color(.systemTeal))
             }
             .padding(.top, 25)
             .padding(.trailing, 10)

         }

        }
 
     
    }
}
