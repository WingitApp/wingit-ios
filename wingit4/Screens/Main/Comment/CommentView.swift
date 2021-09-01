//
//  CommentView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

struct CommentView: View {
    
    @ObservedObject var commentViewModel = CommentViewModel()
    var postId: String?
    @Binding var post: Post
  
//  init(postId: String) {
//    commentViewModel.postId = postId
//    // ToDo: fetch post & comment if DNE
//  }
  
    
    var body: some View {
        VStack {
            ScrollView {
                AskDetail(post: $post).padding(.leading, 15)
                Divider()
            
                
                if !commentViewModel.comments.isEmpty {
                    ForEach(commentViewModel.comments) { comment in
                       CommentRow(comment: comment).padding(.bottom, 10)
                   }
                }
            }
            CommentInput(post: $post)
        }.onTapGesture { dismissKeyboard() }
         .padding(.top, 15).navigationBarTitle(Text(""), displayMode: .inline)
            .onAppear {
              self.commentViewModel.loadComments(postId: post.postId)
            }.onDisappear {
                if self.commentViewModel.listener != nil {
                    self.commentViewModel.listener.remove()
                }
            }
    }
}



//s
