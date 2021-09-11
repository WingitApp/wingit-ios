//
//  AskCard.swift
//  wingit4
//
//  Created by Joshua Lee on 8/22/21.
//

import SwiftUI
import FirebaseAuth

struct AskCard: View {
  
  @State var post: Post
  var isProfileView: Bool
  var index: Int
  
  @EnvironmentObject var homeViewModel: HomeViewModel
  @StateObject var askCardViewModel = AskCardViewModel()
  
  // Menu
  @StateObject var askMenuViewModel = AskMenuViewModel()
  @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
  // Comment
  @StateObject var commentViewModel = CommentViewModel()
  @StateObject var referViewModel = ReferViewModel()
  @StateObject var commentInputViewModel = CommentInputViewModel()
  // Like
  @StateObject var footerCellViewModel = FooterCellViewModel()

//  @StateObject var

  var body: some View {
    if !self.askCardViewModel.isHidden {
      VStack {
        // need to place above to prevent event propagation
        HeaderCell(post: $post)
        NavigationLink( destination:
          AskDetailView(post: $post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
            .environmentObject(commentViewModel)
            .environmentObject(commentInputViewModel)
            .environmentObject(footerCellViewModel)
        ) {
          VStack {
            BodyCell(post: $post)
            FooterCell(post: $post)
          }
        }
        .buttonStyle(FlatLinkStyle())
      }
      .background(
        self.askCardViewModel.getColorByIndex(index: index).opacity(1)
      )
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 0.5)
      )
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
      )
      .modifier(FeedItemShadow())
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
      .environmentObject(askDoneToggleViewModel)
      .environmentObject(commentViewModel)
      .environmentObject(referViewModel)
      .environmentObject(commentInputViewModel)
      .environmentObject(footerCellViewModel)
      // [START] Animates on Hide
      .opacity(!self.askCardViewModel.isHidden ? 1 : 0)
      .transition(.asymmetric(insertion: .scale, removal: .opacity))
      // [END]
      .onAppear{
        self.askCardViewModel.initVM(
          post: post,
          isProfileView: isProfileView
        )
        self.commentViewModel.loadComments(
          postId: post.postId
        )
        self.footerCellViewModel.checkPostIsLiked(post: post)
      }
      .sheet(
        isPresented: $askCardViewModel.isImageModalOpen,
        content: {
          ImageView(post: $post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
      })
      .sheet(
        isPresented: $askMenuViewModel.isReportModalOpen,
        content: {
          ReportInput(post: post, postId: post.postId)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
      })
      .sheet(
        isPresented: $askDoneToggleViewModel.isMarkedAsDone,
        content: {
          DoneToggle(post: post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
      })
      .sheet(
        isPresented: $commentViewModel.isCommentSheetShown,
        content: {
          CommentView(post: $post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
            .environmentObject(commentViewModel)
            .environmentObject(commentInputViewModel)
            .environmentObject(footerCellViewModel)
        })
      .sheet(
        isPresented: $referViewModel.isReferListOpen,
        content: {
          ReferConnectionsList(post: $post)
            .environmentObject(referViewModel)
        })
    }
  }
}
