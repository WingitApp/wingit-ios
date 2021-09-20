//
//  ReferViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/1/21.
//

import SwiftUI
import UIKit
import FirebaseAuth
import Firebase
import Amplitude
import SPAlert

class ReferViewModel : ObservableObject, Identifiable {
    @Published var isLoading = true
    @Published var isChecked = false
    
    @Published var connections: [User] = []
    @Published var userBumps: [User] = []
    @Published var selectedUsers: [User] = []
    
    @Published var isReferListOpen: Bool = false
    
    @Published var userBumpsListener: ListenerRegistration?
  
    func toggleReferListScreen() {
        self.isReferListOpen.toggle()
    }
    
    func toggleCheck() {
      withAnimation {
        self.isChecked.toggle()
      }
    }
    
  func handleUserSelect(user: User) {
      if selectedUsers.contains(user) {
        self.selectedUsers.removeAll(where: { $0 == user })
      } else {
        self.selectedUsers.append(user)
      }

    }
    
    func sendReferrals(askId: String) {
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
    
    func loadConnections(post: Post) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        isLoading = true
      
        Api.Connections.getConnections(userId: userId) { users in
          self.connections = users.compactMap { user in
            if user.id == post.ownerId { return nil }
            return user
          }
          
          self.loadUserBumpers(post: post)
        }
    }
  
    func loadUserBumpers(post: Post) {
      Api.Post.getUserBumpsByPost(
        askId: post.postId,
        onSuccess: { bumpers in
          if bumpers.count > self.userBumps.count {
            self.userBumps = bumpers
          }
          
        },
        onAddition: { bumper in
          if !self.userBumps.contains(bumper) {
            self.userBumps.append(bumper)
          }
        },
        onRemoval: { bumper in
          if !self.userBumps.isEmpty {
              for (index, w) in self.userBumps.enumerated() {
                  if w.uid == bumper.uid {
                    self.userBumps.remove(at: index)
                  }
              }
          }
        },
        listener: { listener in
          self.userBumpsListener = listener
        }
      )
    }
}


