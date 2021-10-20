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
    @Published var inviter: User?
    @Published var inviteCode: String = ""
    @Published var inviterSheetOpen: Bool = false
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var image: Image = Image(IMAGE_USER_PLACEHOLDER)
    @Published var bioText: String = ""
    @Published var imageData: Data = Data()
    @Published var errorString = ""
    @Published var isImagePickerShown: Bool = false
    @Published var isAlertShown: Bool = false
    @Published var showscreen: Bool = false
    @Published var index: Int = 0
    @Environment (\.presentationMode) var presentationMode
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true

  
  
  func addBio(){
    guard let userId = Auth.auth().currentUser?.uid else { return }
    Ref.FS_DOC_USERID(userId: userId).setData(["bio" : bioText], merge: true)
  }
  
  
  func addUserNames(onSuccess: @escaping (_ user: User) -> Void) {
   
    if checkFieldsAreValid() {
      AuthService.addNames(
        firstName: firstName,
        lastName: lastName,
        username: username,
        onSuccess: onSuccess,
        onError: onSignupError
      )
    }
  }
  
  func enrollEmailPass(onSuccess: @escaping (_ user: User) -> Void) {
          AuthService.firstVerification(
            email: email,
            password: password,
            onSuccess: onSuccess,
            onError: onSignupError
            )
  }
  
  func addImage(onSuccess: @escaping (_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
    AuthService.addImage(
      imageData: imageData,
      onSuccess: onSuccess,
      onError: onError
    )
  }
  
    func signup(onSuccess: @escaping (_ user: User) -> Void) {
        self.ampSignupAttemptEvent()
        if checkFirstVerification() {
            
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
  
  func checkFirstVerification() -> Bool {
    if (!isEmailComplete()) {
        self.showErrorMessage(message: "Please fill in all fields")
        return false
    }
    if !String.isValidEmailAddress(emailAddress: email) {
        onSignupError(errorMessage: "Email input is not a valid email address.")
        return false
    }
     return true
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
  
  func isEmailComplete() -> Bool {
    return !email.isEmpty && !password.isEmpty
  }
  
  func clean() {
    firstName = ""
    lastName = ""
    username = ""
    email = ""
    password = ""
  }
  
  func fetchInviter(inviterId: String?) {
    guard let inviterId = inviterId else { return }
    Api.User.loadUser(userId: inviterId) { (user) in
      self.inviter = user
    } onError: {
      print("fetch inviter error")
    }
  }
  
  func acceptInvitation() {
    return
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
