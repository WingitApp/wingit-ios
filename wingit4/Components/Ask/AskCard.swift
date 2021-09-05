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
  
  @EnvironmentObject var homeViewModel: HomeViewModel
  @StateObject var askCardViewModel = AskCardViewModel()
  @StateObject var askMenuViewModel = AskMenuViewModel()
  @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()
  @StateObject var commentViewModel = CommentViewModel()
  @StateObject var referViewModel = ReferViewModel()
  @StateObject var commentInputViewModel = CommentInputViewModel()


  var body: some View {
    if !self.askCardViewModel.isHidden {
      NavigationLink( destination:
        AskDetailView(post: $post)
          .environmentObject(askCardViewModel)
          .environmentObject(askMenuViewModel)
          .environmentObject(askDoneToggleViewModel)
          .environmentObject(commentViewModel)
          .environmentObject(commentInputViewModel)
      ) {
        VStack {
          HeaderCell(post: $post)
          BodyCell(post: $post)
          FooterCell(post: $post)
        }
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.gray, lineWidth: 0.5)
        )
       
      }
      .buttonStyle(PlainButtonStyle())
      .background(Color(.white)).cornerRadius(20)
      .padding(.bottom, 3)
      .padding(.top, 3)
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
      .environmentObject(askDoneToggleViewModel)
      .environmentObject(commentViewModel)
      .environmentObject(referViewModel)
      .environmentObject(commentInputViewModel)
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
        })
      .sheet(
        isPresented: $referViewModel.isReferListOpen,
        content: {
          ReferConnectionsList(post: $post)
            .environmentObject(referViewModel)
        })
        }
      )
    }
  }
}
