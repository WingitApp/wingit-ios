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
    
  @Published var username: String = ""
  @Published var bio: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var image: Image = Image(IMAGE_USER_PLACEHOLDER)
  @Published var imageData: Data = Data()
  @Published var errorString = ""
  @Published var isImagePickerShown: Bool = false
  @Published var isAlertShown: Bool = false
  @Published var showscreen: Bool = false
  @Environment (\.presentationMode) var presentationMode
    

  func signup() {
    self.ampSignupAttemptEvent()
    
    if self.isFormComplete() {
       return AuthService.signupUser(
          username: username,
          bio: bio,
          email: email,
          password: password,
          imageData: imageData,
          onSuccess: onSignupSuccess,
          onError: onSignupError
        )
    }
    self.showErrorMessage(message: "Please fill in all fields")
  }
  
  /// Displays error message through alert (SignInView)
  /// - Parameter message: string of message
  func showErrorMessage(message: String) -> Void {
    self.errorString = message
    self.isAlertShown = true
  }
  
  
  func onSignupSuccess(user: User) {
    ampSignupSuccessEvent(user: user)
    self.clean()
  }
  
  func onSignupError(errorMessage: String) {
    isAlertShown = true
    errorString = errorMessage
    self.clean()
  }
  
  func isFormComplete() -> Bool {
    return !username.isEmpty && !bio.isEmpty && !email.isEmpty && !password.isEmpty
  }
  
  func clean() {
    username = ""
    bio = ""
    email = ""
    password = ""
  }
  
  /// Sends Amplitude event on signup attempt
  func ampSignupAttemptEvent() -> Void {
    logToAmplitude(event: .signupAttempt)
  }
  
  func ampSignupSuccessEvent(user: User) -> Void {
    setUserPropertiesOnAccountCreation(
      userID: user.id!,
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
