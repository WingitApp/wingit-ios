//
//  SigninViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI
import Amplitude


class SigninViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""

    var errorString = ""
    
    @Published var showAlert: Bool = false
    
    
    func signin() -> Void {
        logToAmplitude(event: .loginAttempt)
        
        if self.isFormComplete() {
            AuthService.signInUser(
                email: email,
                password: password,
                onSuccess: { (user) in
                    Amplitude.instance().setUserId(user.uid)
                    logToAmplitude(
                        event: .userLogin,
                        properties: [.method: "email", .platform: "ios"]
                    )
                    self.resetFields()
                },
                onError: { (errorMessage) in
                    self.showAlert = true
                    self.errorString = errorMessage
                    self.resetFields()
                }
            )
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
       
    }
    
    
    func isFormComplete() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    func resetFields() {
        self.email = ""
        self.password = ""
    }
}
