//
//  ConnectionsViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//
//
import SwiftUI
import UIKit
import FirebaseAuth
import Amplitude

class ConnectionsViewModel : ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    func loadConnections(userId: String) {
        isLoading = true
        Api.Connections.getConnections(userId: userId) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
}

