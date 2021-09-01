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
    @Published var checked: Bool = false
  
    
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
    
//    func potentialHelper(userId: String){
//        checked.toggle()
//        
//    }
//    func sendReferral(userId: String){
//        
//        
//    }
   
   
}


