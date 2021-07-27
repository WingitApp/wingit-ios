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

    var post: Post?
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
            CommentInput(post: post, postId: postId)
        }.onTapGesture { dismissKeyboard() }
         .padding(.top, 15).navigationBarTitle(Text(""), displayMode: .inline)
            .onAppear {
                self.commentViewModel.postId = self.post == nil ? self.postId : self.post?.postId
                self.commentViewModel.loadComments()
            }.onDisappear {
                if self.commentViewModel.listener != nil {
                    self.commentViewModel.listener.remove()
                }
            }
    }
}



//struct PostPreview: View {
//    @ObservedObject var commentInputViewModel = CommentInputViewModel()
//
//    init(post: Post?, postId: String?) {
//        if post != nil {
//            commentInputViewModel.post = post
//        } else {
//            handleInputViewModel(postId: postId!)
//        }
//    }
//
//    func handleInputViewModel(postId: String) {
//        Api.Post.loadPost(postId: postId) { (post) in
//            self.commentInputViewModel.post = post
//        }
//    }
//
//
//    var body: some View {
//        VStack(alignment: .leading){
//            HStack {
//                URLImage(URL(string: commentInputViewModel.post.avatar)!,
//                               content: {
//                                   $0.image
//                                       .resizable()
//                                       .aspectRatio(contentMode: .fill)
//                                       .clipShape(Circle())
//                               }).frame(width: 35, height: 35)
//
//                    VStack(alignment: .leading) {
//                        Text(commentInputViewModel.post.username).font(.subheadline).bold()
//                       // Text("location").font(.caption)
//                    }
//                    Spacer()
//            }
//            Text(commentInputViewModel.post.caption).font(.subheadline).padding(.bottom, 2)
//            Text(timeAgoSinceDate(Date(timeIntervalSince1970: commentInputViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
//        }.padding(.leading, 15)
//    }
//}
