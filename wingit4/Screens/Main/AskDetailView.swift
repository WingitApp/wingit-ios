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
    @Binding var post: Post?
    @State private var isNavBarHidden: Bool = true
    
    var body: some View {
 
        ScrollViewReader { proxy in
          VStack(alignment: .leading, spacing: 0) {
          AskDetailHeader(post: $post)
            .background(Color.white)
          Divider()
          ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
            VStack(spacing: 0) {
              AskDetailCard(post: $post)
                .background(Color.white)
              Divider()
              CommentList(post: $post)
            }
          }
          .background(Color.backgroundGray)
          .onTapGesture{
            self.commentViewModel.isTextFieldFocused = false
            dismissKeyboard()
          }
          .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                // onSwipeRight -> go back
                if value.translation.width > 0 {
                  Haptic.impact(type: "soft")
                  self.presentationMode.wrappedValue.dismiss()
                }
            }))
          CommentInput(post: $post, scrollProxyValue: proxy)
        }
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(isNavBarHidden)
      .navigationBarBackButtonHidden(isNavBarHidden)
      .environmentObject(commentViewModel)
      .frame(
        width: UIScreen.main.bounds.size.width
      )
      .onAppear {
        logToAmplitude(event: .viewAskDetailScreen, properties: [.postId: post?.id])
        self.commentViewModel.loadComments(postId: post?.postId)
        self.isNavBarHidden = true
      }
      .onDisappear {
        if self.commentViewModel.listener != nil {
            self.commentViewModel.listener.remove()
        }
      }
    }
    
}

