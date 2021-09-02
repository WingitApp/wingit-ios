//
//  AskDetailView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailView: View {
    @StateObject var commentViewModel = CommentViewModel()
    @Binding var post: Post
    
  
    var body: some View {
      VStack(alignment: .leading) {
        AskDetailCard(post: $post)
        CommentInput(post: $post)
        CommentList(post: $post)
        Spacer()
        
      }
      .environmentObject(commentViewModel)
      .frame(
        width: UIScreen.main.bounds.size.width
//        height: UIScreen.main.bounds.size.height
      )
//      .padding(.top, 200)
//      .padding(.bottom, 200)
      .onAppear {
        self.commentViewModel.loadComments(postId: post.postId)
      }
      .onDisappear {
        if self.commentViewModel.listener != nil {
            self.commentViewModel.listener.remove()
        }
      }
    }
    
}
