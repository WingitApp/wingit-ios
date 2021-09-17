//
//  AskCardViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import SPAlert

class AskCardViewModel: ObservableObject {
  
  // MetaData
  var post: Post = Placeholder.post
  var isProfileView: Bool = false
  
  @Published var postOwner: User!
  @Published var isOwnPost: Bool = false
  @Published var isNavLinkDisabled: Bool = true
  @Published var isLoadingPost: Bool = false
  
  // Modal, Menu, Screens
  @Published var isImageModalOpen: Bool = false
  @Published var isCommentSheetShown = false
  @Published var isReferListOpen: Bool = false
//  @Published var isShareSheetShowing = false
  @Published var isMarkedAsDone: Bool = false

  
  // View Conditional
  @Published var isHidden: Bool = false

 
  func initVM(postId: String?, post: Post?) -> Void {
    if postId == nil {
      self.isOwnPost = Auth.auth().currentUser?.uid == post!.ownerId
      self.isNavLinkDisabled = self.isProfileView || self.isOwnPost
      var status: Bool { return post!.status == .open ? false : true }
      self.isMarkedAsDone = status
    } else {
      self.fetchPostFromId(postId: postId!)
    }
    
  }
  
  func getColorByIndex(index: Int) -> Color {
    let modIndex = index % 4
    
    switch(modIndex) {
//      case 0:
//        return Color.downeyGreen
//      case 1:
//        return Color.apricotWhite
//      case 2:
//        return Color.carnationRed
//      case 3:
//        return Color.tolopeaViolet
//      case 4:
//        return Color.cardGreen
      default:
        return Color.white
    }
  }
  
  func openCloseToggle(post: Post) {
    guard let postId = post.id else { return }
    var newStatus: PostStatus  {
      if post.status == .closed {
        logToAmplitude(event: .reopenAsk)
        return .open
      } else {
        logToAmplitude(event: .markAskAsClosed)
        return .closed
      }
    }

    Api.Post.updateStatus(
      postId: postId,
      newStatus: newStatus
    ) { newStatus in
      self.post.status = newStatus
//      let alertView = SPAlertView(title: "Done!", message: "Woohoo! Congrats!", preset: SPAlertIconPreset.done); alertView.present(duration: 2)
    }
  }
  
  
  func hidePost() {
    
    // hides card on view
    withAnimation {
      self.isHidden.toggle()
    }
    // hides post on BE
//    Api.Post.hidePost(
//      userId: post!.ownerId,
//      postId: post!.postId
//    )
  }
  
  func onTapBlockUser() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
        let postOwnerId = self.post.ownerId
    
    Api.User.blockUser(userId: userId, postOwnerId: postOwnerId)
    
  }
  
  
  func getUserFromPost(){
    let postOwnerId = self.post.ownerId
    Api.User.loadUser(userId: postOwnerId) { (postOwner) in
      self.postOwner = postOwner
//      self.destination = AnyView(UserProfileView(userId: self.post!.ownerId))
    } onError: {
        print("errror")
    }
  }
  
  func removePost() {
    guard let uid = Auth.auth().currentUser?.uid, let postId = self.post.id else { return }
    
    Api.Post.deletePost(
      userId: uid,
      postId: postId
    )
  }
  
  
  func blockUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let postOwnerId = post.ownerId
    Api.User.blockUser(userId: uid, postOwnerId: postOwnerId)
  }

  
}


//API CALLS & FETCHES
extension AskCardViewModel {
  
  func fetchPostFromId( postId: String ) -> Void {
    self.isLoadingPost = true
    Api.Post.loadPost(postId: postId) { post in
      self.post = post!
      self.initVM(postId: nil, post: post!)
      self.isLoadingPost = false
    }
  }
}



/*
 * Sheet Triggers
 */
extension AskCardViewModel {
  
  func toggleCommentScreen() {
    self.isCommentSheetShown.toggle()
  }
  
  func toggleReferListScreen() {
      self.isReferListOpen.toggle()
  }
  
  
 
  
}
