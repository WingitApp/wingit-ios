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
  
  @Published var referrals: [Referral] = []
    
    var listener: ListenerRegistration!
    
    //after accept status is changed, add them into comments.
    /*
     1. send into comment type --> referral.
     2. in comment navigation bring the option for referral comments to come out.
     */
    
    func acceptReferral(referral: Referral, onSuccess: @escaping() -> Void) {
        guard let referralId = referral.id, let currentUser = Auth.auth().currentUser else { return }
        Api.Referrals.updateStatus(referralId: referralId, newStatus: .accepted)
        let text = "\(referral.sender?.username ?? "") invited \(currentUser.displayName ?? "") to help."
        saveReferralToComment(text: text, referral: referral, onSuccess: onSuccess)
    }
    
    func saveReferralToComment(
      text: String,
      referral: Referral,
      onSuccess: @escaping() -> Void) {
      // we return early if there is no logged in user
      guard let currentUser = Auth.auth().currentUser else { return }
        
      let comment: Comment = Comment(
        id: UUID(),
        comment: text,
        avatarUrl: currentUser.photoURL!.absoluteString,
        ownerId: currentUser.uid,
        postId: referral.askId,
        username: currentUser.displayName!,
        date: Date().timeIntervalSince1970
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

