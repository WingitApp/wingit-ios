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
  var isOwnPost: Bool = false
  var isOPComment: Bool = false
  var isTopComment: Bool = false
  
  @State var isNavActive: Bool = false

  
  init(comment: Comment, post: Post?, index: Int, scrollProxyValue: ScrollViewProxy?) {
    self.comment = comment
    self.post = post ?? nil
    self.index = index
    self.scrollProxy = scrollProxyValue ?? nil
    self.isOwnPost = post?.isOwn ?? false
    self.isOPComment = comment.isOwn ?? false
    self.isTopComment = comment.isTopComment ?? false
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
      isPostOwner: isOwnPost,
      isTopComment: isTopComment,
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
  
  func onAppear() {
    if self.isTopComment {
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
            isTopComment: isTopComment,
            onTap: { isNavActive.toggle() }
          )
          CommentText(comment: comment)
          ReactionBar(
            comment: comment,
            isPostOwner: isOwnPost,
            isTopComment: isTopComment,
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
      .background(
        (commentSheetViewModel.isEditingComment && commentSheetViewModel.comment == comment)
        ? LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.1), Color.yellow.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        : isTopComment
          ? LinearGradient(gradient: Gradient(colors: [Color.uilightOrange.opacity(0.6), .white]), startPoint: .top, endPoint: .bottom)
          : LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
      )
      .onTapGesture(count: 2) {
        openCommentActionsSheet()
      }
      .onLongPressGesture(minimumDuration: 0.1, maximumDistance: 1, perform: {
        openCommentActionsSheet()
      })
  
      .environmentObject(reactionBarViewModel)
      .environmentObject(commentSheetViewModel)
      Divider()
    }


}


