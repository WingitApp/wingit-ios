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
import Amplitude

class FollowerViewModel : ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    
    func loadFollowers(userId: String?) {
        if let userId = userId {
            isLoading = true
            Api.Follow.getFollowers(userId: userId) { (users) in
                self.isLoading = false
                self.users = users
                setUserProperty(property: .followers, value: users.count)
            }
        }
    }
    
    func loadFollowing(userId: String?) {
        guard let userId = userId else { return }
        isLoading = true
        Api.Follow.getFollowing(userId: userId) { (users) in
            self.isLoading = false
            self.users = users
            setUserProperty(property: .following, value: users.count)
        }
    }
}

