//
//  AskDetailView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import BottomSheet

struct AskDetailView: View, KeyboardReadable {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @StateObject var commentViewModel = CommentViewModel()
  @StateObject var commentSheetViewModel = CommentSheetViewModel() // for comment actions
  @StateObject var reactionSheetViewModel = ReactionSheetViewModel() // for reaction summary
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
        CommentInput(post: $post, scrollProxyValue: proxy)
      }
      // COMMENT ACTIONS LIST
      .bottomSheet(
        bottomSheetPosition: self.$commentSheetViewModel.bottomSheetPosition,
        options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .background(AnyView(BackgroundBlurView())) ],
        headerContent: {
          CommentSheetHeader()
            .environmentObject(commentSheetViewModel)
        }){
          CommentSheetActionsList(post: post)
            .environmentObject(commentSheetViewModel)
        }
      // REACTION METADATA SUMMARY
        .bottomSheet(
          bottomSheetPosition: self.$reactionSheetViewModel.bottomSheetPosition,
          options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .background(AnyView(BackgroundBlurView())) ],
          headerContent: {
            ReactionSummaryHeader()
              .environmentObject(reactionSheetViewModel)
          }){
            ReactionSummarySheet()
              .environmentObject(reactionSheetViewModel)
          }
    }
    .onReceive(keyboardPublisher) { isKeyboardVisible in
      if isKeyboardVisible, commentSheetViewModel.bottomSheetPosition != .hidden {
        commentSheetViewModel.bottomSheetPosition = .top
      }
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(isNavBarHidden)
    .navigationBarBackButtonHidden(isNavBarHidden)
    .environmentObject(commentViewModel)
    .environmentObject(commentSheetViewModel)
    .environmentObject(reactionSheetViewModel)
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

