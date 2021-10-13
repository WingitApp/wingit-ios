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
      // COMMENT ACTIONS LIST
      .bottomSheet(
        bottomSheetPosition: self.$commentSheetViewModel.bottomSheetPosition,
        options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .background(AnyView(BackgroundBlurView())) ],
        headerContent: {
          CommentSheetHeader()
            .environmentObject(commentSheetViewModel)
        }){
          CommentActionsList(post: post)
            .environmentObject(commentSheetViewModel)
        }
      // REACTION METADATA SUMMARY
//        .bottomSheet(
//          bottomSheetPosition: self.$commentSheetViewModel.bottomSheetPosition,
//          options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss, .background(AnyView(BackgroundBlurView())) ],
//          headerContent: {
//            CommentSheetHeader()
//              .environmentObject(commentSheetViewModel)
//          }){
//            CommentActionsList(post: post)
//              .environmentObject(commentSheetViewModel)
//          }
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

