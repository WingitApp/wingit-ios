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
  @State var post: Post?
  var isProfileView: Bool
  var index: Int = 0
  var referral: Referral?
  
  
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

  func openReferConnectionsList() -> Void{
    referViewModel.toggleReferListScreen()
  }
  
  func navigateToAskCardDetailView() -> Void {
    Haptic.impact(type: "soft")
    commentViewModel.toggleCommentScreen()
  }

  var body: some View {
    if !self.askCardViewModel.isHidden {
      VStack(alignment: .leading) {
        // need to place above to prevent event propagation
        HStack {
          BumperCountSummary(
            users: self.askCardViewModel.bumpers,
            showDescription: true
          )
          .redacted(reason: askCardViewModel.isLoadingBumpers ? .placeholder : [])
          Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
        .onTapGesture(perform: openReferConnectionsList)
        Divider()
          HeaderCell(post: $post, index: index)
        VStack {
          BodyCell(post: $post)
          FooterCell(post: $post)
        }
        .onTapGesture(perform: navigateToAskCardDetailView)
        NavigationLink(
          destination: AskDetailView(post: $post)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
            .environmentObject(askDoneToggleViewModel)
            .environmentObject(commentViewModel)
            .environmentObject(commentInputViewModel)
            .environmentObject(referViewModel),
          isActive: $commentViewModel.isCommentSheetShown
        ) {
          EmptyView()
        }.hidden()
        
      }
      .background(
//        self.askCardViewModel.getColorByIndex(index: index).opacity(1)
        Color.white
      )
      .modifier(CardStyle())
      .modifier(FeedItemShadow())
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
        self.askCardViewModel.initVM(
          post: post,
          isProfileView: isProfileView
        )
        self.commentViewModel.loadComments(
          postId: post?.postId
        )
//        self.footerCellViewModel.checkPostIsLiked(post: post)
      }

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
          ReportInput(post: post, postId: post?.postId)
            .environmentObject(askCardViewModel)
            .environmentObject(askMenuViewModel)
      })
      .sheet(
        isPresented: $referViewModel.isReferListOpen,
        content: {
          if let ref = referral {
            ReferConnectionsList(post: $post, referral: ref)
              .environmentObject(referViewModel)
          } else {
            ReferConnectionsList(post: $post)
              .environmentObject(referViewModel)
          }

        })
    }
  }
}
