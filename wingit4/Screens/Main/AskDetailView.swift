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
 
      VStack(alignment: .leading, spacing: 0) {
        Divider()
        AskDetailHeader(post: $post)
        Divider()
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
          AskDetailCard(post: $post)
          CommentList(post: $post)
        }
        CommentInput(post: $post)
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .edgesIgnoringSafeArea(.top)
      .padding(.top, 10)
      .environmentObject(commentViewModel)
      .frame(
        width: UIScreen.main.bounds.size.width
//        height: UIScreen.main.bounds.size.height
      )
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
