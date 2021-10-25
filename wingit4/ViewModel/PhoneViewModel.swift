//
//  PhoneViewModel.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PhoneViewModel: ObservableObject {
  @Published var phoneNumber = ""
  
  @Published var code = ""
  
  // getting country Phone Code....
  
  // DataModel For Alert View...
  @Published var alertError = false
  @Published var alertMessage = ""
  @Published var alertShown = false
  @AppStorage("authVerificationID") var authVerificationId = ""
  // Loading View....
  @Published var loading = false
  
  func getCountryCode() -> String {
    let regionCode = Locale.current.regionCode ?? ""
    return countries[regionCode] ?? ""
  }
  
  func sendCode(onSuccess: @escaping() -> Void) {
    Auth.auth().settings?.isAppVerificationDisabledForTesting = false
    
    let number = "+\(getCountryCode())\(phoneNumber)"
    PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (authVerificationId, err) in
      
      if let error = err {
        print(error)
        DispatchQueue.main.async {
          self.alertError = true
          self.alertMessage = error.localizedDescription
          withAnimation{ self.alertShown.toggle() }
        }
        return
      } else {
        UserDefaults.standard.set(authVerificationId, forKey: "authVerificationID")
        self.authVerificationId = authVerificationId ?? ""
        self.alertError = false
        onSuccess()
      }
    }
  }
  
  func verifyCode(user: User?, isLoggedIn: Bool, onSuccess: @escaping() -> Void) {
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")

    let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? self.authVerificationId, verificationCode: code)
    
    loading = true
    
    if isLoggedIn {
      Auth.auth().currentUser?.link(with: credential) { authResult, error in
        if error != nil {
          self.alertError = true
          self.alertMessage = error?.localizedDescription ?? "Phone number already in use"
          withAnimation{ self.alertShown.toggle()}
        } else {
          Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
              print(error.localizedDescription)
            } else {
              Api.Phone.addPhoneNumber(userId: authResult?.user.uid, phoneNumber: self.phoneNumber)
              print(authResult?.user.uid ?? "phone verification success")
            }
          }
        }
      }
    } else {
      Auth.auth().signIn(with: credential) { (result, err) in
        self.loading = false
        if let error = err {
          print(error)
          self.alertError = true
          self.alertMessage = "Invalid code for user"
          withAnimation{ self.alertShown.toggle()}
          return
        }
      }
    }
  }
  
  func requestCode(onSuccess: @escaping() -> Void) {
    sendCode() {
      DispatchQueue.main.async {
        withAnimation {
          onSuccess()
        }
      }
    }
  }
}
