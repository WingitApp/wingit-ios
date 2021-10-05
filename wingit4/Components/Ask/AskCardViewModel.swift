//
//  AskCardViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import Firebase
import SPAlert

class AskCardViewModel: ObservableObject {
  
  // Props
  var post: Post?
  var isProfileView: Bool = false
  
  // Bumpers State
  @Published var bumpers: [User] = []
  @Published var isLoadingBumpers: Bool = false
  @Published var listenerBumpers: ListenerRegistration?
  
  // Wingers State
  @Published var wingers: [User] = []
  @Published var isLoadingWingers: Bool = false
  @Published var listenerWingers: ListenerRegistration?
  
  @Published var postOwner: User!
  @Published var isOwnPost: Bool = false
  @Published var isNavLinkDisabled: Bool = true
  
  // Modal, Menu, Screens
  @Published var isImageModalOpen: Bool = false
  @Published var isMarkedAsDone: Bool = false
  
  // View Conditional
  @Published var isHidden: Bool = false
  
  
  func initVM(post: Post?, isProfileView: Bool) -> Void {
//    self.isLoading = true
    self.post = post
    self.isProfileView = isProfileView
    self.isOwnPost = Auth.auth().currentUser?.uid == post?.ownerId
    self.isNavLinkDisabled = self.isProfileView || self.isOwnPost
    var isPostClosed: Bool {
      if post?.status == .open {
        return false
      } else {
        return true
      }
    }
    self.isMarkedAsDone = isPostClosed
    self.getBumpersByPostId(postId: post?.postId) // bumps (now wings)
    self.getWingersByPostId(postId: post?.postId) // accepters
  }
  
  func getBumpersByPostId(postId: String?) {
    guard let postId = postId else { return }
    self.bumpers = []
    isLoadingBumpers =  true
    Api.Post.loadBumpers(
      postId: postId,
      onEmpty: {
        self.isLoadingBumpers = false
      },
      onSuccess: { (bumpers) in
        if self.bumpers.count < bumpers.count {
          self.bumpers = bumpers
          self.isLoadingBumpers = false
        }
      },
      onAddition: { (bumper) in
        if !self.bumpers.isEmpty {
            if !self.bumpers.contains(bumper) {
              self.bumpers.append(bumper)
            }
        }
      },
      onRemoval: { (bumper) in
        if !self.bumpers.isEmpty {
            for (index, w) in self.bumpers.enumerated() {
                if w.uid == bumper.uid {
                    self.bumpers.remove(at: index)
                }
            }
        }
      },
      listener: { listenerHandler in
        self.listenerBumpers = listenerHandler
    })
  }
  
  func getWingersByPostId(postId: String?) {
    guard let postId = postId else { return }
    self.wingers = []
    isLoadingWingers =  true
    
    Api.Post.loadWingers(
      postId: postId,
      onSuccess: { (wingers) in
        if self.wingers.count < wingers.count {
          self.wingers = wingers
          self.isLoadingWingers = false
        }
      },
      onAddition: { (winger) in
        if !self.wingers.isEmpty {
            if !self.wingers.contains(winger) {
              self.wingers.append(winger)
            }
        }
      },
      onRemoval: { (winger) in
        if !self.wingers.isEmpty {
            for (index, w) in self.wingers.enumerated() {
                if w.uid == winger.uid {
                    self.wingers.remove(at: index)
                }
            }
        }
      },
      listener: { listenerHandler in
        self.listenerWingers = listenerHandler
    })
  }
  
//  func getColorByIndex(index: Int) -> Color {
//    let modIndex = index % 5
//
//    switch(modIndex) {
//      case 0:
//        return Color.downeyGreen
//      case 1:
//        return Color.apricotWhite
//      case 2:
//        return Color.carnationRed
//      case 3:
//        return Color.violet
//      case 4:
//        return Color.orange
//      default:
//        return Color.white
//    }
//  }
  
  
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
        guard let userId = Auth.auth().currentUser?.uid,
              let postOwnerId = self.post?.ownerId else { return }
    
    Api.User.blockUser(userId: userId, postOwnerId: postOwnerId)
    
  }
  
  
  func removePost() {
    guard let uid = Auth.auth().currentUser?.uid, let postId = self.post?.id else { return }
    
    Api.Post.deletePost(
      userId: uid,
      postId: postId
    )
  }
  
  
  func blockUser() {
    guard let uid = Auth.auth().currentUser?.uid,
          let postOwnerId = post?.ownerId else { return }
    Api.User.blockUser(userId: uid, postOwnerId: postOwnerId)
  }
  
  func openCloseToggle(
    post: Post?,
    onSuccess: @escaping(_ newStatus: PostStatus) -> Void
  ) {
    guard let postId = post?.id else { return }
    var newStatus: PostStatus  {
      if post?.status == .closed {
        logToAmplitude(event: .reopenAsk)
        return .open
      } else {
        logToAmplitude(event: .markAskAsClosed)
        return .closed
      }
    }

    Api.Post.updateStatus(
      postId: postId,
      newStatus: newStatus,
      onSuccess: onSuccess
    )
  }

  
}
