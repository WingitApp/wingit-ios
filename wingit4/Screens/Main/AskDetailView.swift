//
//  AskDetailView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailView: View {
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var askCardViewModel = AskCardViewModel()
    @StateObject var askMenuViewModel = AskMenuViewModel()
  
    var postId: String?
    var post: Post?
    var isProfileView: Bool = false
  
  
    var body: some View {
 
      VStack(alignment: .leading) {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
          AskDetailCard(post: askCardViewModel.post)
          CommentList(post: askCardViewModel.post)
          Spacer()
        }
        CommentInput(post: askCardViewModel.post)
      }
      .redacted(reason: self.askCardViewModel.isLoadingPost ? .placeholder :[])
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
      .environmentObject(commentViewModel)
      .padding(.top, -10)
      .frame(
        width: UIScreen.main.bounds.size.width
      )
      .onAppear {
        self.commentViewModel.loadComments(postId: askCardViewModel.post.postId)
        self.askCardViewModel.initVM(postId: postId, post: post)
        self.askCardViewModel.isProfileView = isProfileView
      }
      .onDisappear {
        if self.commentViewModel.listener != nil {
            self.commentViewModel.listener.remove()
        }
      }
    }
    
}
