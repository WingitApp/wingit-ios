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
  @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var errorString: String = ""
  @Published var isAlertShown: Bool = false
    
  
  /// Signin user (Called from SignInView)
  func signin() {
    self.ampSignInAttemptEvent()
    
    if (self.isFormComplete()) { // Auth only when fields are filled
        shouldShowOnboarding = false
        return AuthService.signInUser(
            email: email,
            password: password,
            onSuccess: onSignInSuccess,
            onError: onSignInError
        )
    }
    
    self.showErrorMessage(message: "Please fill in all fields")
  }
  
  /// Callback on signin success
  func onSignInSuccess(user: User) -> Void {
    self.ampSignInSuccessEvent(user: user)
    self.resetFields()
  }
  
  /// Callback on signin error
  func onSignInError(errorMessage: String) -> Void{
    self.showErrorMessage(message: errorMessage)
  }
  
  /// Displays error message through alert (SignInView)
  /// - Parameter message: string of message
  func showErrorMessage(message: String) -> Void {
    self.errorString = message
    self.isAlertShown = true
  }
  
  /// Sends Amplitdue event on signin attempt
  func ampSignInAttemptEvent() -> Void {
    logToAmplitude(event: .loginAttempt)
  }
  
  /// Sends Amplitude event on signin success
  /// - Parameter user: User object
  func ampSignInSuccessEvent(user: User) -> Void {
    Amplitude.instance().setUserId(user.id)
    logToAmplitude(
        event: .userLogin,
        properties: [.method: "email", .platform: "ios"]
    )
  }
  
  /// Checks if required fields are filled and not empty.
  /// - Returns: Boolean - true if complete; false if empty
  func isFormComplete() -> Bool {
      return !email.isEmpty && !password.isEmpty
  }
  
  /// Resets the `email` and `password` fields to empty states
  func resetFields() -> Void {
      email = ""
      password = ""
  }
}
