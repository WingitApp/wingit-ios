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
//  @State var isActive: Bool = false


  
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
          HStack(alignment: .center) {
              Text(comment.username ?? "")
              .font(.system(size:13))
              .fontWeight(.semibold)
            if isTopComment {
              HStack(spacing: 3){
                Text(Image(systemName: "star.circle.fill"))
                Text("Best Answer")
              }
              .foregroundColor(Color.uiorange)
              .font(.system(size: 10))
            }
            Circle()
            .modifier(CircleDotStyle())
            Text(
              timeAgoSinceDate(
                Date(timeIntervalSince1970: comment.date ?? 0),
                currentDate: Date(),
                numericDates: true
              )
            )
              .foregroundColor(.gray)
              .font(.system(size: 10))
            
          }
          .onTapGesture(perform: { isNavActive.toggle() })

          
          Text(comment.comment?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
          .font(.system(size:15))
          .padding(.top, 1)
          .onLongPressGesture(minimumDuration: 0.1) {
            openCommentActionsSheet()
          }
          // Emoji Bar
          ReactionBar(comment: comment, isPostOwner: postOwnerId == session.currentUser?.uid, isTopComment: isTopComment)
        }
        .padding(.leading, 5)
        
      }
      .onAppear(perform: loadReactionBar)
      .onDisappear(perform: removeListener)
      .padding(15)
      .background(
        isTopComment
         ? LinearGradient(gradient: Gradient(colors: [Color.uilightOrange.opacity(0.6), .white]), startPoint: .top, endPoint: .bottom)
        : nil
      )
      .environmentObject(reactionBarViewModel)
      Divider()
    }

}


