//
//  AskDetailView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var commentViewModel = CommentViewModel()
    
    @Binding var post: Post
    
  
    var body: some View {
 
        ScrollViewReader { proxy in
          VStack(alignment: .leading, spacing: 0) {
          AskDetailHeader(post: $post)
            .background(Color.white)
          Divider()
            .foregroundColor(Color.black)
          ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            VStack(spacing: 0) {
              AskDetailCard(post: $post)
                .background(Color.white)
              Divider()
              CommentList(post: $post)
            }
          }
          .background(Color.backgroundGray)
          .onTapGesture(perform: dismissKeyboard)
          CommentInput(post: $post, scrollProxyValue: proxy)
        }
          .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width > 0 {
                    // right
                  Haptic.impact(type: "soft")
                  self.presentationMode.wrappedValue.dismiss()
                }
            }))
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
      .edgesIgnoringSafeArea(.top)
      .padding(.top, 10)
      .environmentObject(commentViewModel)
      .frame(
        width: UIScreen.main.bounds.size.width
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

