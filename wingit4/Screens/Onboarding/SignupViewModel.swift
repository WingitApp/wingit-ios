//
//  SignupViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI

class SignupViewModel: ObservableObject {
    
  @Published var firstName: String = ""
  @Published var lastName: String = ""
  @Published var username: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var image: Image = Image(IMAGE_USER_PLACEHOLDER)
  @Published var imageData: Data = Data()
  @Published var errorString = ""
  @Published var isAlertShown: Bool = false
  @Published var showscreen: Bool = false
  @Environment (\.presentationMode) var presentationMode
    

    func signup(onSuccess: @escaping (_ user: User) -> Void) {
        self.ampSignupAttemptEvent()
        
        if checkFieldsAreValid() {
           return AuthService.signupUser(
              firstName: firstName,
              lastName: lastName,
              username: username,
              email: email,
              password: password,
              imageData: imageData,
              onSuccess: onSuccess,
              onError: onSignupError
            )
        }
  }
    
    func checkFieldsAreValid() -> Bool {
        if (!isFormComplete()) {
            self.showErrorMessage(message: "Please fill in all fields")
            return false
        }
        if !String.isValidEmailAddress(emailAddress: email) {
            onSignupError(errorMessage: "Email input is not a valid email address.")
            return false
        }
        if !String.isValidUsername(username: username) {
            onSignupError(errorMessage: "Username must be alphanumeric or underscores with no whitespaces.")
            return false
        }
        return true
    }
  
  /// Displays error message through alert (SignInView)
  /// - Parameter message: string of message
  func showErrorMessage(message: String) -> Void {
    self.errorString = message
    self.isAlertShown = true
  }
  
  
  func onSignupSuccess(user: User) {
    ampSignupSuccessEvent(user: user)
  }
  
  func onSignupError(errorMessage: String) {
    isAlertShown = true
    errorString = errorMessage
  }
  
  func isFormComplete() -> Bool {
    return !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty && !email.isEmpty && !password.isEmpty
  }
  
  func clean() {
    firstName = ""
    lastName = ""
    username = ""
    email = ""
    password = ""
  }
  
  /// Sends Amplitude event on signup attempt
  func ampSignupAttemptEvent() -> Void {
    logToAmplitude(event: .signupAttempt)
  }
  
  func ampSignupSuccessEvent(user: User) -> Void {
    setUserPropertiesOnAccountCreation(
        userId: user.id,
      firstName: user.firstName,
        lastName: user.lastName,
        username: user.username,
      email: user.email,
      signupMethod: "email"
    )
    logToAmplitude(
      event: .userSignup,
      properties: [.method: "email", .platform: "ios"]
    )
  }
  
    
}
