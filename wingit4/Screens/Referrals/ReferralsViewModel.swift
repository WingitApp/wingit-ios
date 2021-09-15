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
        Api.Referrals.getPendingReferrals() { referrals in
            self.pendingReferrals = referrals
        }
    }
    
    func getAcceptedReferrals() {
        Api.Referrals.getAcceptedReferrals() { referrals in
            self.acceptedReferrals = referrals
        }
    }
    
    func getWingedReferrals() {
        Api.Referrals.getWingedReferrals() { referrals in
            self.wingedReferrals = referrals
        }
    }
    
    func getClosedReferrals() {
        Api.Referrals.getClosedReferrals() { referrals in
            self.closedReferrals = referrals
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
