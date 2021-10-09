//
//  AskDetailView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import BottomSheet

struct AskDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var commentViewModel = CommentViewModel()
    @StateObject var commentSheetViewModel = CommentSheetViewModel()
    @Binding var post: Post?
    @State private var isNavBarHidden: Bool = true
  
    @State private var bottomSheetPosition: BottomSheetPosition = .hidden
  
    
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
          .bottomSheet(
            bottomSheetPosition: self.$commentSheetViewModel.bottomSheetPosition,
            options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .background(AnyView(BackgroundBlurView())) ],
            headerContent: {
              CommentSheetHeader()
                .environmentObject(commentSheetViewModel)
//              VStack(spacing: 0){
//                HStack(alignment: .center, spacing: 0) {
//                  Text(commentSheetViewModel.comment?.comment ?? "")
//                    .font(.caption)
//                }
//                .frame(width: UIScreen.main.bounds.width, height: 40)
//                  .padding(.bottom, 15)
//                Divider()
//                  .padding(0)
//              }
//              .padding(.vertical, 10)
//              .background(Color.white)
            }){
              CommentActionsList()
//                .background(Color.white)
                .environmentObject(commentSheetViewModel)
          }
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(isNavBarHidden)
      .navigationBarBackButtonHidden(isNavBarHidden)
      .environmentObject(commentViewModel)
      .environmentObject(commentSheetViewModel)
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

