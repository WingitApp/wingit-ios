//
//  gemCommentView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/19/21.
//

import SwiftUI
import URLImage

struct gemCommentView: View {
    
    @ObservedObject var commentViewModel = CommentViewModel()

    var gempost: gemPost?
    var postId: String?
    
    
    var body: some View {
        VStack {
            ScrollView {
//                PostPreview(post: post, postId: postId).padding(.leading, 15)
//                Divider()
            
                
                if !commentViewModel.comments.isEmpty {
                    ForEach(commentViewModel.comments) { comment in
                       CommentRow(comment: comment).padding(.bottom, 10)
                   }
                }
            }
            gemCommentInput(gempost: gempost, postId: postId)
        }.onTapGesture { dismissKeyboard() }
         .padding(.top, 15).navigationBarTitle(Text(""), displayMode: .inline)
            .onAppear {
                self.commentViewModel.postId = self.gempost == nil ? self.postId : self.gempost?.postId
                self.commentViewModel.loadComments()
            }.onDisappear {
                if self.commentViewModel.listener != nil {
                    self.commentViewModel.listener.remove()
                }
            }
    }
}


