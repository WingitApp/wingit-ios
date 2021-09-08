//
//  DoneCell.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//

import SwiftUI
import URLImage
import FirebaseAuth

struct DoneCard: View {

    let uid = Auth.auth().currentUser!.uid
    @State var ImageScreen: Bool = false
    @State var reportScreen: Bool = false
    @ObservedObject var doneViewModel = DoneViewModel()
    @ObservedObject var commentViewModel = CommentViewModel()
    @State var showComments : Bool = false
    
    init(donepost: DonePost) {
        self.doneViewModel.donepost = donepost
    }
    
    
    var body: some View {
        
        VStack{
        DoneHeader(donepost: self.doneViewModel.donepost)
        DoneBody(donepost: self.doneViewModel.donepost)
        DoneFooter(donepost: self.doneViewModel.donepost)
        
        }.padding(.top, 10).padding(.bottom, 10)
        .background(Color(.white)).cornerRadius(20)
        .sheet(isPresented: $ImageScreen, content: {
            doneImageView(donepost: doneViewModel.donepost)
        })
        .sheet(isPresented: $showComments, content: {
//            CommentView(postId: doneViewModel.donepost.postId)
        })
        .onAppear {
            self.commentViewModel.postId = doneViewModel.post == nil ? doneViewModel.donepost.postId : doneViewModel.donepost.postId
          self.commentViewModel.loadComments(postId: doneViewModel.donepost!.postId)
        }
        .onDisappear {
            if self.commentViewModel.listener != nil {
                self.commentViewModel.listener.remove()
            }}
    }

}
