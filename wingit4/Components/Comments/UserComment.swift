//
//  Comment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import FirebaseAuth

struct UserComment: View {
  @EnvironmentObject var commentSheetViewModel: CommentSheetViewModel
  @EnvironmentObject var session: SessionStore
  @StateObject var reactionBarViewModel = ReactionBarViewModel()
  
  var comment: Comment
  var post: Post?
  var index: Int
  var scrollProxy: ScrollViewProxy?
  
  @State var isPressed = false
  @State var isNavActive: Bool = false
  
  
  init(comment: Comment, post: Post?, index: Int, scrollProxyValue: ScrollViewProxy?) {
    self.comment = comment
    self.post = post ?? nil
    self.index = index
    self.scrollProxy = scrollProxyValue ?? nil
  }
  
  func scrollToComment() {
    guard let scrollProxy = self.scrollProxy else { return }
    withAnimation {
      scrollProxy.scrollTo(self.index)
    }
  }
  
  func openCommentActionsSheet() {
    Haptic.impact(type: "soft")
    dismissKeyboard()
    commentSheetViewModel.openCommentSheet(
      comment: comment,
      isOwnPost: post?.isOwn ?? false,
      reactions: reactionBarViewModel.reactions,
      scrollToComment: self.scrollToComment
    ) {
      //todo
    }
  }
  
  func showCommentDeleteConfirmation() {
    commentSheetViewModel.isConfirmationShown = false
    commentSheetViewModel.deleteComment()
  }
  
  func getBackgroundByState() -> LinearGradient {
    
    if commentSheetViewModel.isEditingComment && commentSheetViewModel.comment == comment {
      return LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.1), Color.yellow.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
    }
    
    if comment.isTopComment ?? false {
      return LinearGradient(gradient: Gradient(colors: [Color.uilightOrange.opacity(0.6), .white]), startPoint: .top, endPoint: .bottom)
    }
    
    return LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
  }
  
  func onAppear() {
    
    if self.comment.isTopComment ?? false {
      self.commentSheetViewModel.currentTopCommentId = comment.docId ?? nil
    }
    self.loadReactionBar()
  }
  
  func loadReactionBar() {
    reactionBarViewModel.fetchReactions(comment: comment)
  }
  
  func removeListener() {
    guard let listener = self.reactionBarViewModel.listener else { return }
    listener.remove()
  }
  
  
  var body: some View {
    HStack(alignment: .top) {
      NavigationLink(
        destination: ProfileView(userId: comment.ownerId, user: nil),
        isActive: $isNavActive
      ) {
        EmptyView()
      }.hidden()
      URLImageView(urlString: comment.avatarUrl)
        .clipShape(Circle())
        .frame(width: 35, height: 35, alignment: .center)
        .foregroundColor(Color.wingitBlue)
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(Color.gray, lineWidth: 0.5)
        )
        .onTapGesture(perform: { isNavActive.toggle() })
      
      VStack(alignment: .leading) {
        CommentHeader(
          comment: comment,
          isTopComment: comment.isTopComment ?? false,
          onTap: { isNavActive.toggle() }
        )
        CommentText(comment: comment)
        ReactionBar(
          comment: comment,
          isOwnPost: post?.isOwn ?? false,
          scrollToComment: scrollToComment
        )
      }
      .padding(.leading, 5)
      
    }
    .alert(isPresented: $commentSheetViewModel.isConfirmationShown) {
      Alert(
        title: Text("Delete your comment?"),
        message: Text("This action cannot be undone."),
        primaryButton: .destructive(Text("Delete")) {
          showCommentDeleteConfirmation()
        },
        secondaryButton: .cancel()
      )
    }
    .onAppear(perform: onAppear)
    .onDisappear(perform: removeListener)
    .padding(15)
    .background(getBackgroundByState())
    .scaleEffect(isPressed ? 0.995 : 1)
    .onTapGesture(count: 2) {
      openCommentActionsSheet()
    }
    .onLongPressGesture(
      minimumDuration: 0.1,
      maximumDistance: 1,
      pressing: { value in
        self.isPressed = value
      },
      perform: {
        openCommentActionsSheet()
      })
    
    .environmentObject(reactionBarViewModel)
    .environmentObject(commentSheetViewModel)
    Divider()
  }
  
  
}


