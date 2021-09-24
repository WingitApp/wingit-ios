//
//  AskDetailCard.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailCard: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @EnvironmentObject var askMenuViewModel: AskMenuViewModel
  @EnvironmentObject var referViewModel: ReferViewModel
  @EnvironmentObject var commentViewModel: CommentViewModel

  

  @Binding var post: Post
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        AskDetailBody(post: $post)
        VStack(alignment: .leading) {
          AskCollaborationDetail()
        }
        .padding([.horizontal])
      }
      .onAppear {
        if askCardViewModel.wingers.isEmpty && askCardViewModel.bumpers.isEmpty {
          askCardViewModel.initVM(post: post, isProfileView: false)
        }
      }
      .environmentObject(referViewModel)
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
      .environmentObject(commentViewModel)
      .sheet(
        isPresented: $askCardViewModel.isImageModalOpen,
        content: {
          ImageView(post: $post)
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
        isPresented: $referViewModel.isReferListOpen,
        content: {
          ReferConnectionsList(post: $post)
            .environmentObject(referViewModel)
        })
    }
  
}
