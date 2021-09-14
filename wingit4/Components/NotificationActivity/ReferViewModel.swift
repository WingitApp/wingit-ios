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
    @Published var selectedUsers: [String?] = []
    @Published var isChecked = false
    
    var allReferralRecipientIds: [String?] = []
    var allUsers: [User] = []
    
    @Published var isReferListOpen: Bool = false
  
    func toggleReferListScreen() {
        self.isReferListOpen.toggle()
    }
    
    func toggleCheck() {
      withAnimation {
        self.isChecked.toggle()
      }
    }
    
    func handleUserSelect(userId: String?) {
        guard let userId = userId else { return }
        if selectedUsers.contains(userId) {
            self.selectedUsers.removeAll(where: { $0 == userId })
        } else {
            self.selectedUsers.append(userId)
        }

    }
    
    func sendReferrals(askId: String) {
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
    
    func rewingReferral(askId: String, parentId: String?) {
        guard let parentId = parentId else { return }
        Api.Referrals.updateStatus(referralId: parentId, newStatus: .winged)
        for receiverId in selectedUsers {
            Api.Referrals.rewingReferral(
                askId: askId,
                receiverId: receiverId,
                parentId: parentId,
                senderId: Auth.auth().currentUser!.uid
            )
        }
        
        self.allReferralRecipientIds = Array(Set(self.allReferralRecipientIds + self.selectedUsers))
        let alertView = SPAlertView(title: "Sent!", message: nil, preset: SPAlertIconPreset.done); alertView.present(duration: 2)
        self.toggleReferListScreen()
    }
    
    func loadConnections(askId: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading.toggle()
            self.allUsers = users
            Api.Referrals.getReferralsByAskId(askId: askId) { (recipientIds) in
                self.allReferralRecipientIds = recipientIds
            }
        }
    }
}


