//
//  AskDetail.swift
//  wingit4
//
//  Created by Joshua Lee on 8/31/21.
//

import SwiftUI
import URLImage

//truct PostPreview: View {
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


struct AskDetail: View {
  @ObservedObject var commentInputViewModel = CommentInputViewModel()
  @Binding var post: Post

  
//      init(post: Post?, postId: String?) {
//          if post != nil {
//              commentInputViewModel.post = post
//          } else {
//              handleInputViewModel(postId: postId!)
//          }
//      }
//  
      func handleInputViewModel(postId: String) {
//          Api.Post.loadPost(postId: postId) { (post) in
//              self.commentInputViewModel.post = post
//          }
      }
  
  
      var body: some View {
        HeaderCell(post: $post)
//          VStack(alignment: .leading){
//              HStack {
//                  URLImage(URL(string: commentInputViewModel.post.avatar)!,
//                                 content: {
//                                     $0.image
//                                         .resizable()
//                                         .aspectRatio(contentMode: .fill)
//                                         .clipShape(Circle())
//                                 }).frame(width: 35, height: 35)
//
//                      VStack(alignment: .leading) {
//                          Text(commentInputViewModel.post.username).font(.subheadline).bold()
//                         // Text("location").font(.caption)
//                      }
//                      Spacer()
//              }
//              Text(commentInputViewModel.post.caption).font(.subheadline).padding(.bottom, 2)
//              Text(timeAgoSinceDate(Date(timeIntervalSince1970: commentInputViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray)
//          }.padding(.leading, 15)
      }
}
