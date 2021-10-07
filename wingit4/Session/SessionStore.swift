//
//  SessionStore.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import SwiftUI

class SessionStore: ObservableObject {
    @Published var isLoggedIn = false
    @Published var currentUser: User?
    @Published var isSessionLoading: Bool = true
  
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                Api.User.loadUser(
                    userId: user.uid,
                    onSuccess: { (decodedUser) in
                        // user successfully found
                        self.currentUser = decodedUser
                        Api.Device.updateDeviceInFirestore(token: "")
                        self.isLoggedIn = true
                        self.isSessionLoading = false
                    },
                    onError: {
                        // todo: user doc DNE
                        print("error fetching user")
                        self.isLoggedIn = true
                        self.isSessionLoading = false

                })
            } else {
                self.isLoggedIn = false
                self.currentUser = nil
                self.isSessionLoading = false
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            shouldShowOnboarding = true
            logToAmplitude(event: .userLogout, userId: self.currentUser?.id)
        } catch  {

        }
    }
    
    // stop listening for auth changes
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
