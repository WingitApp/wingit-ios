//
//  ReferViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/1/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import Amplitude
import SPAlert

class ReferViewModel : ObservableObject, Identifiable {
    @Published var isLoading = true
    @Published var selectedUsers: [String] = []
    @Published var isChecked = false
    
    // Lists to generate allowedUsers
    var allReferralRecipientIds: [String] = []
    var allUsers: [User] = []

    // List to generate ReferConnectionsList
    @Published var filteredUsers: [User] = []
    
    @Published var isReferListOpen: Bool = false
  
    func toggleReferListScreen() {
        self.isReferListOpen.toggle()
    }
    
    func toggleCheck() {
      withAnimation {
        self.isChecked.toggle()
      }
    }
    
    func handleUserSelect(userId: String) {
        if selectedUsers.contains(userId) {
            self.selectedUsers.removeAll(where: { $0 == userId })
        } else {
            self.selectedUsers.append(userId)
        }

    }
    
    func sendReferral(askId: String) {
        ///askId(postId) & senderId (auth.dude) & senderId(userId of the one selected
        // ids -> self.selectedUsers
        
        for receiverId in selectedUsers {
            Api.Referrals.sendReferral(
                askId: askId,
                receiverId: receiverId,
                senderId: Auth.auth().currentUser!.uid
            )
        }
        
        self.allReferralRecipientIds = Array(Set(self.allReferralRecipientIds + self.selectedUsers))
        let alertView = SPAlertView(title: "Sent!", message: nil, preset: SPAlertIconPreset.done); alertView.present(duration: 2)
        self.toggleReferListScreen()
    }
    
    func bumpReferral(askId: String) {
        guard let receiverId = Auth.auth().currentUser?.uid else {return}
        Api.Referrals.statusToBumped(askId: askId, receiverId: receiverId)
        // id of person who bumped --> current user
        // id of the new receiver
        
/*
         1. Change status to bumped for the previous referral document.
         2. Toggle new screen for the connections list for new referral
         3. Create new referral document with the new receiver & ask Ids.
         */

     
//            .where("ask")
//            .setData([ "status": true ], merge: true)
    }
    
    //after accept status is changed, add them into comments.
    
    func acceptReferral(askId: String) {
        guard let receiverId = Auth.auth().currentUser?.uid else {return}
        Api.Referrals.acceptReferral(askId: askId, receiverId: receiverId)
    }
    
    //when Referral ignored, status changed.
    func ignoreReferral(askId: String) {
        guard let receiverId = Auth.auth().currentUser?.uid else {return}
        Api.Referrals.ignoreReferral(askId: askId, receiverId: receiverId)
    }
    
    func loadConnections(askId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading.toggle()
            self.allUsers = users
            
            // gets users who've already been referred
            Api.Referrals.getReferralsByAskId(askId: askId) { (recipientIds) in
                // compare referrals with allusers
//                var filteredUsers: [User] = []
//
//                for user in self.allUsers {
//                    if (!recipientIds.contains(user.id!)) {
//                        filteredUsers.append(user)
//                    }
//                }
////
                self.allReferralRecipientIds = recipientIds
//                self.filteredUsers = filteredUsers
            }
        }
    }
    
}


