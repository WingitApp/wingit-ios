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

class ReferViewModel : ObservableObject, Identifiable {
    @Published var isLoading = true
    @Published var users: [User] = []
    @Published var selectedUsers: [String] = []
    @Published var isChecked = false
  
    func toggleCheck() {
      withAnimation {
        self.isChecked.toggle()
      }
    }
    
//    func clean(){
//        
//    }
    
    func handleUserSelect(userId: String) {
        if selectedUsers.contains(userId) {
            self.selectedUsers.removeAll(where: { $0 == userId })
        } else {
            self.selectedUsers.append(userId)
        }

    }
    
    func sendReferral(askId: String, mediaUrl: String) {
        ///askId(postId) & senderId (auth.dude) & senderId(userId of the one selected
        // ids -> self.selectedUsers
        
        for receiverId in selectedUsers {
            Api.Referrals.sendReferral(
                askId: askId,
                mediaUrl: mediaUrl,
                receiverId: receiverId,
                senderId: Auth.auth().currentUser!.uid
            )
        }
    }
    
    func loadConnections() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        if !self.isLoading {
            isLoading.toggle()
        }
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading.toggle()
            self.users = users
        }
    }
 
   
}


