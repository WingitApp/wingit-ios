//
//  FooterCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import URLImage

struct FooterCell: View {
    
    @ObservedObject var footerCellViewModel = FooterCellViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    
    init(post: Post) {
        self.footerCellViewModel.post = post
        self.footerCellViewModel.checkPostIsLiked()
    }
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Image(systemName: (self.footerCellViewModel.isLiked) ? "hand.raised.fill" : "hand.raised").onTapGesture {
                    if self.footerCellViewModel.isLiked {
                        self.footerCellViewModel.unlike()
                    } else {
                        self.footerCellViewModel.like()
                    }
                }
                if footerCellViewModel.post.likeCount > 0 {
                    Text("\(footerCellViewModel.post.likeCount)").font(.caption).foregroundColor(.gray)
                        //.padding(.leading, 15).padding(.top, 5)
                }
               
                HStack{
//                    NavigationLink(
//                        destination: CommentView(post: self.footerCellViewModel.post),
//                        label: {
//                            Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15)
//                        })
                    Button(action: {showComments.toggle()},
                           label: {
                            Image(systemName: "message").foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                    })
                if !commentViewModel.comments.isEmpty {
                    Text("\(commentViewModel.comments.count)").foregroundColor(.gray).font(.caption)
                }
                }
                Spacer()
            }.padding(.trailing, 15).padding(.leading, 15)
           
            RecButton().padding(.trailing, 15).padding(.leading, 15)
            
            Divider()
          
        }
        .sheet(isPresented: $showComments, content: {
            CommentView(post: self.footerCellViewModel.post)
        })
        .onAppear {
            self.commentViewModel.postId = self.footerCellViewModel.post == nil ? self.footerCellViewModel.post.postId : self.footerCellViewModel.post?.postId
            self.commentViewModel.loadComments()
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }
        }
    
    }
}


