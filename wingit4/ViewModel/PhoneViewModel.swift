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

    @Published var phoneNo = ""
    
    @Published var code = ""
    
    // getting country Phone Code....
    
    // DataModel For Error View...
    @Published var errorMsg = ""
    @Published var error = false
    
    // storing CODE for verification...
    @Published var CODE = ""
    
    @Published var gotoVerify = false
    
    // User Logged Status
    @AppStorage("log_Status") var status = false
    @AppStorage("authVerificationID") var authVerificationId: String?
    // Loading View....
    @Published var loading = false
    
    func getCountryCode() -> String {
      let regionCode = Locale.current.regionCode ?? ""
      return countries[regionCode] ?? ""
    }
    
    func sendCode(onSuccess: @escaping() -> Void) {
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
      let user = Auth.auth().currentUser
      let number = "+\(getCountryCode())\(phoneNo)"
      user?.multiFactor.getSessionWithCompletion({ (session, error) in
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil, multiFactorSession: session) { (verificationId, err) in
          self.authVerificationId = verificationId
          if let error = err {
            DispatchQueue.main.async {
              self.errorMsg = error.localizedDescription
              withAnimation{ self.error.toggle() }
            }
            return
          } else {
            onSuccess()
          }
        }
      })
    }
    
    func verifyCode(onSuccess: @escaping() -> Void) {
      let user = Auth.auth().currentUser
      let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.authVerificationId!, verificationCode: self.CODE)
      let assertion = PhoneMultiFactorGenerator.assertion(with: credential)
      user?.multiFactor.enroll(with: assertion, displayName: user?.displayName) { (error) in
        if let error = error {
          DispatchQueue.main.async {
            self.errorMsg = error.localizedDescription
            withAnimation{ self.error.toggle() }
          }
          return
        } else {
          onSuccess()
        }
      }
    }
    
  func requestCode() {
    sendCode() {
      DispatchQueue.main.async {
        withAnimation {
          self.errorMsg = "Code Sent Successfully"
          self.error.toggle()
        }
      }
    }
  }
}

