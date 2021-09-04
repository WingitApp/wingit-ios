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
      HStack(alignment: .top, spacing: 0) {
            URLImage(URL(string: session.currentUser!.profileImageUrl)!,
              content: {
                  $0.image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      .clipShape(Circle())
              }).frame(width: 50, height: 50
            )
              .padding(
                EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
              )
            ZStack {
//               RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1)
//                .padding()
//                .padding(.leading, 10)
               HStack {
                   TextView("Add a comment", text: $composedMessage)
                    .border(Color.black, width: 1)
                    .padding(
                      EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
                    )
                    //        }
                   Button(action: commentAction) {
                       Image(systemName: "arrow.right.circle").imageScale(.large).foregroundColor(.black).padding(30)
                   }
               }

             }.frame(height: 70)
        }
 
     
    }
}
