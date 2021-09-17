//
//  AskCard.swift
//  wingit4
//
//  Created by Joshua Lee on 8/22/21.
//

import SwiftUI
import FirebaseAuth

struct AskCard: View {
  // Props (passed from parents)
  var post: Post
  var isProfileView: Bool
  var index: Int = 0
  
  
  // Observable Objects
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


  var body: some View {
    if !self.askCardViewModel.isHidden {
      VStack {
        // need to place above to prevent event propagation
        HeaderCell(post: post)
        NavigationLink( destination: AskDetailView(postId: post.postId, post: post, isProfileView: isProfileView) ) {
          VStack {
            BodyCell(post: post)
            FooterCell(post: post)
          }
        }
        .buttonStyle(FlatLinkStyle())
      }
      .background(
        self.askCardViewModel.getColorByIndex(index: index).opacity(1)
      )
      .modifier(CardStyle())
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
          postId: nil,
          post: post
        )
        self.commentViewModel.loadComments(
          postId: post.postId
        )
        self.footerCellViewModel.checkPostIsLiked(post: post)
      }
      .sheet(
        isPresented: $askCardViewModel.isImageModalOpen,
        content: {
          ImageView(post: post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
      })
      .sheet(
        isPresented: $askMenuViewModel.isReportModalOpen,
        content: {
          ReportInput(post: post, postId: post.postId)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
      })
      .sheet(
        isPresented: $askCardViewModel.isCommentSheetShown,
        content: {
          CommentView(post: post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(commentViewModel)
            .environmentObject(commentInputViewModel)
            .environmentObject(footerCellViewModel)
        })
      .sheet(
        isPresented: $askCardViewModel.isReferListOpen,
        content: {
          ReferConnectionsList(post: post)
            .environmentObject(referViewModel)
        })
    }
  }
}
