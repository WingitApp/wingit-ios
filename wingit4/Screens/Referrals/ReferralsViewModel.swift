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
    @Published var pendingReferrals: [Referral] = []
    @Published var acceptedReferrals: [Referral] = []
    @Published var wingedReferrals: [Referral] = []
    @Published var closedReferrals: [Referral] = []
    
    var pendingListener: ListenerRegistration!
    var acceptedListener: ListenerRegistration!
    var wingedListener: ListenerRegistration!
    var closedListener: ListenerRegistration!
    
    func getReferrals() {
        
        getPendingReferrals()
        getAcceptedReferrals()
        getWingedReferrals()
        getClosedReferrals()
    }
    
    func getPendingReferrals() {
      Api.Referrals.getPendingReferrals(
        onSuccess: { (referrals) in
          if self.pendingReferrals.isEmpty {
              self.pendingReferrals = referrals
          }
      }, newReferral: { (referral) in
          if !self.pendingReferrals.isEmpty {
            if !self.pendingReferrals.contains(referral) {
              self.pendingReferrals.insert(referral, at: 0)
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.pendingReferrals.isEmpty {
              if let index = self.pendingReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.pendingReferrals[index] = referral
              }
            }
      }, deleteReferral: { (referral) in
          if !self.pendingReferrals.isEmpty {
              for (index, r) in self.pendingReferrals.enumerated() {
                  if r.id == referral.id {
                    self.pendingReferrals.remove(at: index)
                  }
              }
          }
      }) { (listener) in
        self.pendingListener = listener
      }
    }
    
    func getAcceptedReferrals() {
      Api.Referrals.getAcceptedReferrals(
        onSuccess: { (referrals) in
          if self.acceptedReferrals.isEmpty {
              self.acceptedReferrals = referrals
             
          }
      }, newReferral: { (referral) in
          if !self.acceptedReferrals.isEmpty {
            if !self.acceptedReferrals.contains(referral) {
              self.acceptedReferrals.insert(referral, at: 0)
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.acceptedReferrals.isEmpty {
              if let index = self.acceptedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.acceptedReferrals[index] = referral
              }
            }
      }, deleteReferral: { (referral) in
          if !self.acceptedReferrals.isEmpty {
              for (index, r) in self.acceptedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.acceptedReferrals.remove(at: index)
                  }
              }
          }
      }) { (listener) in
        self.acceptedListener = listener
      }
    }
    
    func getWingedReferrals() {
      Api.Referrals.getWingedReferrals(
        onSuccess: { (referrals) in
          if self.wingedReferrals.isEmpty {
              self.wingedReferrals = referrals
       
          }
      }, newReferral: { (referral) in
          if !self.wingedReferrals.isEmpty {
            if !self.wingedReferrals.contains(referral) {
              self.wingedReferrals.insert(referral, at: 0)
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.wingedReferrals.isEmpty {
              if let index = self.wingedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.wingedReferrals[index] = referral
              }
            }
      }, deleteReferral: { (referral) in
          if !self.wingedReferrals.isEmpty {
              for (index, r) in self.wingedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.wingedReferrals.remove(at: index)
                  }
              }
          }
      }) { (listener) in
        self.wingedListener = listener
      }
    }
    
    func getClosedReferrals() {
      Api.Referrals.getClosedReferrals(
        onSuccess: { (referrals) in
          if self.closedReferrals.isEmpty {
              self.closedReferrals = referrals
            
          }
      }, newReferral: { (referral) in
          if !self.closedReferrals.isEmpty {
            if !self.closedReferrals.contains(referral) {
              self.closedReferrals.insert(referral, at: 0)
            }
          }
      }, modifiedReferral: { (referral) in
            if !self.closedReferrals.isEmpty {
              if let index = self.closedReferrals.firstIndex(where: {$0.id == referral.id}) {
                self.closedReferrals[index] = referral
              }
            }
      }, deleteReferral: { (referral) in
          if !self.closedReferrals.isEmpty {
              for (index, r) in self.closedReferrals.enumerated() {
                  if r.id == referral.id {
                    self.closedReferrals.remove(at: index)
                  }
              }
          }
      }) { (listener) in
        self.closedListener = listener
      }
    }
    
    func acceptReferral(referral: Referral, onSuccess: @escaping() -> Void) {
        guard let referralId = referral.id, let currentUser = Auth.auth().currentUser else { return }
        Api.Referrals.updateStatus(referralId: referralId, newStatus: .accepted)
        let text = "\(referral.sender?.displayName ?? "") invited \(currentUser.displayName ?? "") to help."
        postInvitedReferralComment(text: text, referral: referral, onSuccess: onSuccess)
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
      Api.Comment.sendComment(
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
