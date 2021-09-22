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
    
    @Published var connections: [User] = []
    @Published var userBumps: [User] = []
    @Published var selectedUsers: [User] = []
    
    @Published var isReferListOpen: Bool = false
    @Published var showOnSuccessAnimation: Bool = false
    
    @Published var userBumpsListener: ListenerRegistration?
  
    func resetToInitialState() {
      isLoading = true
      showOnSuccessAnimation = false
      connections = []
      userBumps = []
      selectedUsers = []
      if userBumpsListener != nil {
        userBumpsListener!.remove()
      }
    }
  
    func toggleReferListScreen() {
        self.isReferListOpen.toggle()
    }
    
  
    func toggleSuccessAnimation() {
      withAnimation {
        showOnSuccessAnimation.toggle()
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
       for receivers in selectedUsers {
           let receiverId = receivers.id
           Api.Referrals.sendReferral(
               askId: askId,
               receiverId: receiverId,
               senderId: Auth.auth().currentUser!.uid
           )
       }
       
      self.toggleSuccessAnimation()
    }
    
    func rewingReferral(askId: String, parentId: String?) {
       guard let parentId = parentId else { return }
       Api.Referrals.updateStatus(referralId: parentId, newStatus: .winged)
       for receiver in selectedUsers {
          let receiverId = receivers.id
           Api.Referrals.rewingReferral(
               askId: askId,
               receiverId: receiverId,
               parentId: parentId,
               senderId: Auth.auth().currentUser!.uid
           )
       }
      self.toggleSuccessAnimation()
    }
    
    func loadConnections(post: Post) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        isLoading = true
      
        Api.Connections.getConnections(userId: userId) { users in
          self.connections = users.compactMap { user in
            if user.id == post.ownerId { return nil }
            return user
          }.sorted(by: {
            $0.firstName! < $1.firstName!
          })
          
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


