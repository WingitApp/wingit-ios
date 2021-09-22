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
      VStack(alignment: .leading, spacing: 0) {
        AskDetailBody(post: $post)
        VStack(alignment: .leading) {
          if askCardViewModel.bumpers.count + askCardViewModel.wingers.count > 0 {
            Text("Collaborators")
              .font(.system(size:14))
              .fontWeight(.semibold)
            BumperCountSummary(users: askCardViewModel.bumpers + askCardViewModel.wingers)
              .padding(.bottom, 15)
          }
        }
        .padding([.horizontal])
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
