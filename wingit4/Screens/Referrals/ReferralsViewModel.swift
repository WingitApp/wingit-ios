//
//  ReferralViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/2/21.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseAuth
import Amplitude
import SPAlert

class ReferralsViewModel: ObservableObject {
    // Referrals By Type
    @Published var pendingReferrals: [Referral] = []
    @Published var acceptedReferrals: [Referral] = []
    @Published var wingedReferrals: [Referral] = []
    @Published var closedReferrals: [Referral] = []
    // Loading State
    @Published var isLoading: Bool = true
    @Published var isFetchingPending: Bool = true
    @Published var isFetchingAccepted: Bool = true
    @Published var isFetchingWinged: Bool = true
    @Published var isFetchingClosed: Bool = true
  
    // Programatically Navigate
    @Published var destination: AskDetailView?
    @Published var isLinkActive: Bool = false
    
    var pendingListener: ListenerRegistration!
    var acceptedListener: ListenerRegistration!
    var wingedListener: ListenerRegistration!
    var closedListener: ListenerRegistration!
    
    func getReferrals() {      
      // initialize call
      isLoading = true
      let referralAPIGroup = DispatchGroup()
      getPendingReferrals(dispatchGroup: referralAPIGroup)
      getAcceptedReferrals(dispatchGroup: referralAPIGroup)
      getWingedReferrals(dispatchGroup: referralAPIGroup)
      getClosedReferrals(dispatchGroup: referralAPIGroup)
    
      // on finish
      referralAPIGroup.notify(queue: .main)  {
        let isDoneFetching = (
          !self.isFetchingPending &&
          !self.isFetchingAccepted &&
          !self.isFetchingWinged &&
          !self.isFetchingClosed
        )
                
        if isDoneFetching {
          self.isLoading = false
        }
      }

    }
    
  func getPendingReferrals(dispatchGroup: DispatchGroup?) {
      isFetchingPending = true
      guard let dispatch = dispatchGroup else { return }
      dispatch.enter()
      Api.Referrals.getPendingReferrals(
        onEmpty: {
          if self.isFetchingPending {
            self.isFetchingPending = false
            guard let dispatch = dispatchGroup else { return }
            dispatch.leave()
          }
        },
        onSuccess: { (referrals) in
          if self.pendingReferrals.isEmpty {
              self.pendingReferrals = referrals
              if self.isFetchingPending {
                self.isFetchingPending = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }, newReferral: { (referral) in
          if !self.pendingReferrals.isEmpty {
            if !self.pendingReferrals.contains(referral) {
              self.pendingReferrals.insert(referral, at: 0)
              if self.isFetchingPending {
                self.isFetchingPending = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.pendingReferrals.isEmpty {
              if let index = self.pendingReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.pendingReferrals[index] = referral
                if self.isFetchingPending {
                  self.isFetchingPending = false
                  guard let dispatch = dispatchGroup else { return }
                  dispatch.leave()
                }
              }
            }
      }, deleteReferral: { (referral) in
          if !self.pendingReferrals.isEmpty {
              for (index, r) in self.pendingReferrals.enumerated() {
                  if r.id == referral.id {
                    self.pendingReferrals.remove(at: index)
                  }
              }
              if self.isFetchingPending {
                self.isFetchingPending = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }

          }
      }) { (listener) in
        self.pendingListener = listener
      }
    }
    
    func getAcceptedReferrals(dispatchGroup: DispatchGroup?) {
      isFetchingAccepted = true
      guard let dispatch = dispatchGroup else { return }
      dispatch.enter()
      Api.Referrals.getAcceptedReferrals(
        onEmpty: {
          if self.isFetchingAccepted {
            self.isFetchingAccepted = false
            guard let dispatch = dispatchGroup else { return }
            dispatch.leave()
          }
        },
        onSuccess: { (referrals) in
          if self.acceptedReferrals.isEmpty {
              self.acceptedReferrals = referrals
              if self.isFetchingAccepted {
                self.isFetchingAccepted = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }, newReferral: { (referral) in
          if !self.acceptedReferrals.isEmpty {
            if !self.acceptedReferrals.contains(referral) {
              self.acceptedReferrals.insert(referral, at: 0)
              if self.isFetchingAccepted {
                self.isFetchingAccepted = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.acceptedReferrals.isEmpty {
              if let index = self.acceptedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.acceptedReferrals[index] = referral
              } else {
                self.acceptedReferrals.insert(referral, at: 0)
              }
              if self.isFetchingAccepted {
                self.isFetchingAccepted = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
      }, deleteReferral: { (referral) in
          if !self.acceptedReferrals.isEmpty {
              for (index, r) in self.acceptedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.acceptedReferrals.remove(at: index)
                  }
              }
              if self.isFetchingAccepted {
                self.isFetchingAccepted = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }) { (listener) in
        self.acceptedListener = listener
      }
    }
    
    func getWingedReferrals(dispatchGroup: DispatchGroup?) {
      self.isFetchingWinged = true
      guard let dispatch = dispatchGroup else { return }
      dispatch.enter()
      Api.Referrals.getWingedReferrals(
        onEmpty: {
          if self.isFetchingWinged {
            self.isFetchingWinged = false
            guard let dispatch = dispatchGroup else { return }

            dispatch.leave()
          }
        },
        onSuccess: { (referrals) in
          if self.wingedReferrals.isEmpty {
              self.wingedReferrals = referrals
              if self.isFetchingWinged {
                self.isFetchingWinged = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }, newReferral: { (referral) in
          if !self.wingedReferrals.isEmpty {
            if !self.wingedReferrals.contains(referral) {
              self.wingedReferrals.insert(referral, at: 0)
              if self.isFetchingWinged {
                self.isFetchingWinged = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.wingedReferrals.isEmpty {
              if let index = self.wingedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.wingedReferrals[index] = referral
              } else {
                self.wingedReferrals.insert(referral, at: 0)
              }
              if self.isFetchingWinged {
                self.isFetchingWinged = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
      }, deleteReferral: { (referral) in
          if !self.wingedReferrals.isEmpty {
              for (index, r) in self.wingedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.wingedReferrals.remove(at: index)
                  }
              }
              if self.isFetchingWinged {
                self.isFetchingWinged = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }) { (listener) in
        self.wingedListener = listener
      }
    }
    
    func getClosedReferrals(dispatchGroup: DispatchGroup?) {
      isFetchingClosed = true
      guard let dispatch = dispatchGroup else { return }
      dispatch.enter()
      Api.Referrals.getClosedReferrals(
        onEmpty: {
          if self.isFetchingClosed {
            self.isFetchingClosed = false
            guard let dispatch = dispatchGroup else { return }
            dispatch.leave()
          }
        },
        onSuccess: { (referrals) in
          if self.closedReferrals.isEmpty {
              self.closedReferrals = referrals
              if self.isFetchingClosed {
                self.isFetchingClosed = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }, newReferral: { (referral) in
          if !self.closedReferrals.isEmpty {
            if !self.closedReferrals.contains(referral) {
              self.closedReferrals.insert(referral, at: 0)
              if self.isFetchingClosed {
                self.isFetchingClosed = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.closedReferrals.isEmpty {
              if let index = self.closedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.closedReferrals[index] = referral
              } else {
                self.closedReferrals.insert(referral, at: 0)
              }
              if self.isFetchingClosed {
                self.isFetchingClosed = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
            }
      }, deleteReferral: { (referral) in
          if !self.closedReferrals.isEmpty {
              for (index, r) in self.closedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.closedReferrals.remove(at: index)
                  }
              }
              if self.isFetchingClosed {
                self.isFetchingClosed = false
                guard let dispatch = dispatchGroup else { return }
                dispatch.leave()
              }
          }
      }) { (listener) in
        self.closedListener = listener
      }
    }
    
    func acceptReferral(referral: Referral, post: Binding<Post?>) {
        guard let referralId = referral.id, let currentUser = Auth.auth().currentUser else { return }
        Api.Referrals.updateStatus(
          referralId: referralId,
          newStatus: .accepted
        )
        let text = "\(referral.sender?.displayName ?? "") invited \(currentUser.displayName ?? "") to help."
        postInvitedReferralComment(text: text, referral: referral) {
          self.destination = AskDetailView(post: post)
          self.isLinkActive = true
        }
    }
    
    func postInvitedReferralComment(
      text: String,
      referral: Referral,
      onSuccess: @escaping() -> Void) {
      // we return early if there is no logged in user
      guard let currentUser = Auth.auth().currentUser else { return }
        
      let comment: Comment = Comment(
        id: UUID(),
        comment: text,
        avatarUrl: currentUser.photoURL!.absoluteString,
        inviterAvatarUrl: referral.sender?.profileImageUrl,
        inviterDisplayName: referral.sender?.displayName,
        inviterId: referral.sender?.id,
        ownerId: currentUser.uid,
        postId: referral.askId,
        username: currentUser.displayName!,
        date: Date().timeIntervalSince1970,
        type: .invitedReferral
      )
      
      guard let commentDict = try? comment.toDictionary() else {return}
      Api.Comment.postComment(
        commentDict: commentDict,
        postId: referral.askId,
        onSuccess: onSuccess) { print($0) }
      }
    
    //when Referral ignored, status changed.
    func ignoreReferral(referralId: String?) {
            guard let referralId = referralId else { return }
            Api.Referrals.updateStatus(referralId: referralId, newStatus: .closed)
    }
}
