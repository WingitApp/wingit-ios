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
  @AppStorage("inviterId") var inviterId = ""
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
  @Published var index: OnboardingScreen = .signupOrLogin
  @Published var percent: CGFloat = 0

  @Environment (\.presentationMode) var presentationMode
  @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
  
  func addBio() {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    Ref.FS_DOC_USERID(userId: userId).setData(["bio" : bioText], merge: true)
  }
  
  func addUsersNames(onSuccess: @escaping () -> Void) {
    
    if nameFieldsAreValid() {
      Api.User.addNames(
        firstName: firstName,
        lastName: lastName,
        username: username,
        onSuccess: onSuccess,
        onError: onSignupError
      )
    }
  }
  
  func emailSignup(onSuccess: @escaping (_ user: User) -> Void) {
    if emailPassFieldsValid() {
      AuthService.emailSignup(
        email: email,
        password: password,
        inviterId: inviter?.id,
        onSuccess: onSuccess,
        onError: onSignupError
      )
    }
  }
  
  func addImage() {
    if imageData.count != 0 {
      Api.User.updateImage(imageData: imageData, onSuccess: {_ in }, onError: {_ in })
    }
  }
  
    func emailPassFieldsValid() -> Bool {
        if (!emailPassFieldsComplete()) {
            self.showErrorMessage(message: "Fields cannot be empty")
            return false
        }
        if !String.isValidEmailAddress(emailAddress: email) {
            onSignupError(errorMessage: "Email input is not a valid email address.")
            return false
        }

        return true
    }
  
  func nameFieldsAreValid() -> Bool {
      if (!nameFieldsComplete()) {
          self.showErrorMessage(message: "Fields cannot be empty")
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
    DispatchQueue.main.async {
      self.errorString = message
      self.isAlertShown.toggle()
    }
  }
  
  func onSignupSuccess(user: User) {
    ampSignupSuccessEvent(user: user)
  }
  
  func onSignupError(errorMessage: String) {
    isAlertShown = true
    errorString = errorMessage
  }
  
  func nameFieldsComplete() -> Bool {
    return !firstName.isEmpty && !lastName.isEmpty && !username.isEmpty
  }
  
  func emailPassFieldsComplete() -> Bool {
    return !email.isEmpty && !password.isEmpty
  }
  
  func verifyInviteCode() {
    let trimmedCode = inviteCode.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmedCode.count != INVITE_CODE_LENGTH {
      if trimmedCode.count == 0 {
        showErrorMessage(message: "Please enter an invite code")
      } else {
        showErrorMessage(message: "Invite code must be \(INVITE_CODE_LENGTH) characters")
      }
    } else {
      Api.User.findUser(
        inviteCode: trimmedCode,
        onSuccess: { user in self.inviter = user; self.inviterSheetOpen.toggle() },
        onEmpty: {
          self.showErrorMessage(message: "Code is invalid")
        },
        onError: { errorMessage in self.showErrorMessage(message: errorMessage) })
    }
  }
  
  func fetchInviter(inviterId: String?) {
    guard let inviterId = inviterId else { return }
    self.inviterId = inviterId
    self.inviteCode = String(inviterId.prefix(INVITE_CODE_LENGTH))
    Api.User.loadUser(userId: inviterId) { (user) in
      DispatchQueue.main.async {
        self.inviter = user
      }
    } onError: {
      print("fetch inviter error")
    }
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
      email: user.email ?? "",
      signupMethod: "email",
      inviterId: user.id
    )
    logToAmplitude(
      event: .userSignup,
      properties: [.method: "email", .inviter: user.id, .platform: "ios"]
    )
  }
}
