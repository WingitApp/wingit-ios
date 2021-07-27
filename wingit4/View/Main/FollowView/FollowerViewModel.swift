//
//  FollowerViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/14/21.
//
//
import SwiftUI
import UIKit
import FirebaseAuth

class FollowerViewModel : ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    func loadFollowers(userId: String) {
        isLoading = true
        Api.Follow.getFollowers(userId: userId) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
    func loadFollowing(userId: String) {
        isLoading = true
        Api.Follow.getFollowing(userId: userId) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
}

