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

class SessionStore: ObservableObject {
    @Published var isLoggedIn = false
    var currentUser: User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: user.uid)
                  firestoreUserId.getDocument { (document, error) in
                      if let dict = document?.data() {
                          guard let decoderUser = try? User.init(fromDictionary: dict) else { return }
                        self.currentUser = decoderUser
                        self.isLoggedIn = true
                      }
                  }
            } else {
                self.isLoggedIn = false
                self.currentUser = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            logToAmplitude(event: .userLogout, userId: self.currentUser?.uid)
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
