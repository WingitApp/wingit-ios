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
  

  @Binding var post: Post
  
    var body: some View {
      VStack(alignment: .leading) {
        AskDetailHeader(post: $post)
        AskDetailBody(post: $post)
        // AskDetailRow shows the linear progression on bumps
        WingersRow(wingers: $askCardViewModel.wingers)
        AskDetailFooter(post: $post)
      }
      .environmentObject(referViewModel)
      .environmentObject(askCardViewModel)
      .environmentObject(askMenuViewModel)
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
    }
  
}
