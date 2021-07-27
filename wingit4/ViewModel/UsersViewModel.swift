//
//  UsersViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    var searchText: String = ""
    
    func searchTextDidChange() {
        isLoading = true
        //Api.User.searchUsers(text: searchText)
        Api.User.searchUsers(text: searchText) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
}
