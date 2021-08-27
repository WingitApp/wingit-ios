//
//  AskCard.swift
//  wingit4
//
//  Created by Joshua Lee on 8/22/21.
//

import SwiftUI

struct AskCard: View {
  
  @State var post: Post
  var isProfileView: Bool
  
  @EnvironmentObject var homeViewModel: HomeViewModel
  @StateObject var askCardViewModel = AskCardViewModel()
  @StateObject var askMenuViewModel = AskMenuViewModel()
  @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
  @StateObject var commentViewModel = CommentViewModel()


  var body: some View {
    if !self.askCardViewModel.isHidden {
      VStack{
        HeaderCell(post: $post)
        BodyCell(post: $post)
        FooterCell(post: $post)
      }
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
      .environmentObject(askDoneToggleViewModel)
      .environmentObject(commentViewModel)
      // [START] Animates on Hide
      .opacity(!self.askCardViewModel.isHidden ? 1 : 0)
      .transition(.asymmetric(insertion: .scale, removal: .opacity))
      // [END]
      .onAppear{
        askCardViewModel.initVM(
          post: post,
          isProfileView: isProfileView
        )
      }
      .sheet(
        isPresented: $askCardViewModel.isImageModalOpen,
        content: {
          ImageView(post: $post)
      })
      .sheet(
        isPresented: $askMenuViewModel.isReportModalOpen,
        content: {
          ReportInput(post: post, postId: post.postId)
      })
      .sheet(
        isPresented: $askDoneToggleViewModel.isMarkedAsDone,
        content: {
          DoneToggle(post: post)
      })
      .sheet(
        isPresented: $commentViewModel.isCommentSheetShown,
        content: {
          CommentView(post: $post)
        }
      )
    }
  }
}
