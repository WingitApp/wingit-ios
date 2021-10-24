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
    @AppStorage("authVerificationID") var authVerificationId: String?
    // Loading View....
    @Published var loading = false
    
    func getCountryCode() -> String {
      let regionCode = Locale.current.regionCode ?? ""
      return countries[regionCode] ?? ""
    }
    
    func sendCode(onSuccess: @escaping() -> Void) {
      Auth.auth().settings?.isAppVerificationDisabledForTesting = false
      
      let number = "+\(getCountryCode())\(phoneNo)"
      PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (authVerificationId, err) in
        
        if let error = err {
          print(error)
          DispatchQueue.main.async {
            self.errorMsg = error.localizedDescription
            withAnimation{ self.error.toggle() }
          }
          return
        } else {
          UserDefaults.standard.set(authVerificationId, forKey: "authVerificationID")
          self.authVerificationId = authVerificationId ?? ""
          onSuccess()
        }
      }
    }
    
    func verifyCode(onSuccess: @escaping() -> Void) {
      
      let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.authVerificationId ?? "", verificationCode: code)
      
      loading = true
      
      Auth.auth().signIn(with: credential) { (result, err) in
          self.loading = false
          if let error = err {
              self.errorMsg = error.localizedDescription
              withAnimation{ self.error.toggle()}
              return
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

