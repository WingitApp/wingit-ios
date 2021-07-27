//
//  MessageViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class MessageViewModel: ObservableObject {
  
   @Published var inboxMessages: [InboxMessage] = [InboxMessage]()
    
   var listener: ListenerRegistration!
    
    init() {
       loadInboxMessages()
           }
   
   func loadInboxMessages() {
       self.inboxMessages = []
       
       Api.Chat.getInboxMessages(onSuccess: { (inboxMessages) in
           if self.inboxMessages.isEmpty {
               self.inboxMessages = inboxMessages
           }
       }, onError: { (errorMessage) in

       }, newInboxMessage: { (inboxMessage) in
           if !self.inboxMessages.isEmpty {
               self.inboxMessages.append(inboxMessage)
           }
       }) { (listener) in
           self.listener = listener
       }
       

   }
}
