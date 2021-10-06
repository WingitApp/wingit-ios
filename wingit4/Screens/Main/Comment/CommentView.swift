//
//  CommentView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

//DEPRECATED 9/20/21

//struct CommentView: View {
//    @EnvironmentObject var commentViewModel: CommentViewModel
//    @Binding var post: Post?
//    
//    var body: some View {
//      NavigationView {
//        VStack {
//            ScrollView {
//              AskDetailCard(post: $post)
//              VStack(alignment: .leading) {
//                ForEach(self.commentViewModel.comments) { comment in
//                  UserComment(comment: comment, postOwnerId: post?.ownerId)
//                 }
//              }
//            }
//            Spacer()
//            CommentInput(post: $post)
//        }
//        .onTapGesture { dismissKeyboard() }
//        .navigationBarTitle("Comments", displayMode: .inline)
//      }
//      .switchStyle(if: UIDevice.current.userInterfaceIdiom == .phone)
//        .onAppear {
//          self.commentViewModel.loadComments(postId: post?.postId)
//        }.onDisappear {
//            if self.commentViewModel.listener != nil {
//                self.commentViewModel.listener.remove()
//            }
//        }
//       .preferredColorScheme(.light)
//    }
//}
