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
  @StateObject var ellipsisMenuViewModel = EllipsisMenuViewModel()
  @StateObject var askDoneToggleViewModel = AskDoneToggleViewModel()

  var body: some View {
    VStack{
      HeaderCell(post: $post)
      BodyCell(post: $post)
      FooterCell(post: $post)
    }
    .environmentObject(askCardViewModel)
    .environmentObject(ellipsisMenuViewModel)
    .environmentObject(askDoneToggleViewModel)
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
      isPresented: $ellipsisMenuViewModel.isReportModalOpen,
      content: {
        ReportInput(post: post, postId: post.postId)
    })
    .sheet(isPresented: $askDoneToggleViewModel.isMarkedAsDone, content: {
        DoneToggle(post: post)
    })
  }
}
