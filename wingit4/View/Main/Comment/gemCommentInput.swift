//
//  gemCommentInput.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/19/21.
//

import SwiftUI
import URLImage


struct gemCommentInput: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentInputViewModel = CommentInputViewModel()
    
    @State var composedMessage: String = ""
    
    init(gempost: gemPost?, postId: String?) {
        if gempost != nil {
            commentInputViewModel.gempost = gempost
        } else {
            handleInputViewModel(postId: postId!)
        }
    }
    
    func handleInputViewModel(postId: String) {
        Api.gemPost.loadPost(postId: postId) { (gempost) in
            self.commentInputViewModel.gempost = gempost
        }
    }
    
    func commentAction() {
        if !composedMessage.isEmpty {
            commentInputViewModel.addGemComments(text: composedMessage) {
                self.composedMessage = ""
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            URLImage(URL(string: session.userSession!.profileImageUrl)!,
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

//struct CommentInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentInput()
//    }
//}
