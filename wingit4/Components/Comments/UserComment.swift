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
  var postOwnerId: String?
  var isOPComment: Bool = false
  var isTopComment: Bool = false
  
  @State var isNavActive: Bool = false

  
  init(comment: Comment, post: Post?, postOwnerId: String?) {
    self.comment = comment
    self.post = post ?? nil
    self.postOwnerId = postOwnerId
    self.isOPComment = comment.ownerId == postOwnerId
    self.isTopComment = post!.topCommentId != nil && post!.topCommentId == comment.id
  }
  
  func openCommentActionsSheet() {
    guard let uid = session.currentUser?.uid else { return }
    Haptic.impact(type: "soft")
    dismissKeyboard()
    commentSheetViewModel.openCommentSheet(
      comment: comment,
      isPostOwner: postOwnerId == uid,
      isTopComment: isTopComment,
      reactions: reactionBarViewModel.reactions
    ) {
//      isActive = true
    }
  }
  
  func removeComment() {
    commentSheetViewModel.isConfirmationShown = false
    commentSheetViewModel.deleteComment()
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
            isPostOwner: postOwnerId == session.currentUser?.uid,
            isTopComment: isTopComment
          )
        }
        .padding(.leading, 5)
        
      }
      .alert(isPresented: $commentSheetViewModel.isConfirmationShown) {
        Alert(
          title: Text("Delete your comment?"),
          message: Text("This action cannot be undone."),
          primaryButton: .destructive(Text("Delete")) {
            removeComment()
          },
          secondaryButton: .cancel()
        )
      }
      .onAppear(perform: loadReactionBar)
      .onDisappear(perform: removeListener)
      .padding(15)
      .background(
        commentSheetViewModel.isEditingComment
        ? LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.1), Color.yellow.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        : isTopComment
          ? LinearGradient(gradient: Gradient(colors: [Color.uilightOrange.opacity(0.6), .white]), startPoint: .top, endPoint: .bottom)
          : LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom)
      )
      .onLongPressGesture(minimumDuration: 0.2) {
        openCommentActionsSheet()
      }
      .environmentObject(reactionBarViewModel)
      .environmentObject(commentSheetViewModel)
      Divider()
    }


}


