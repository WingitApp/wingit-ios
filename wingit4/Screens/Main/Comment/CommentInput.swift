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
    @Binding var post: Post
    @ObservedObject var commentInputViewModel = CommentInputViewModel()
    
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
        HStack(spacing: 0) {
            URLImage(URL(string: session.currentUser!.profileImageUrl)!,
                                                    content: {
                                                        $0.image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .clipShape(Circle())
                                                    }).frame(width: 50, height: 50
            ).padding(.leading, 15)
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
 
     
    }
}

