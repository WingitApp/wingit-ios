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
<<<<<<< HEAD
import SPAlert
=======
>>>>>>> 2b84d60 (refer Connections check experiement)

class ReferViewModel : ObservableObject, Identifiable {
    
    @Published var isLoading = true
<<<<<<< HEAD
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
    
    func sendBump(askId: String, parentId: String) {
        ///askId(postId) & senderId (auth.dude) & senderId(userId of the one selected
        // ids -> self.selectedUsers
        
        for receiverId in selectedUsers {
            Api.Referrals.bumpReferral(
                askId: askId,
                receiverId: receiverId,
                parentId: parentId,
                senderId: Auth.auth().currentUser!.uid
            )
        }
        
        self.allReferralRecipientIds = Array(Set(self.allReferralRecipientIds + self.selectedUsers))
        let alertView = SPAlertView(title: "Sent!", message: nil, preset: SPAlertIconPreset.done); alertView.present(duration: 2)
                self.bumpReferral(referralId: parentId)
        self.toggleReferListScreen()
    }
    
    func bumpReferral(referralId: String?) {
        guard let referralId = referralId else { return }
        Api.Referrals.updateStatus(referralId: referralId, newStatus: .bumped)
        
    }
    
    
    func loadConnections(askId: String) {
=======
    @Published var users: [User] = []
    @Published var checked: Bool = false
  
    
    func loadConnections() {
>>>>>>> 2b84d60 (refer Connections check experiement)
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading.toggle()
<<<<<<< HEAD
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
    
=======
            self.users = users
        }
    }
    
//    func potentialHelper(userId: String){
//        checked.toggle()
//        
//    }
//    func sendReferral(userId: String){
//        
//        
//    }
   
   
>>>>>>> 2b84d60 (refer Connections check experiement)
}


