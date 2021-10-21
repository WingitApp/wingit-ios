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
      Auth.auth().settings?.isAppVerificationDisabledForTesting = false
      
      let number = "+\(getCountryCode())\(phoneNo)"
      PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (authVerificationId, err) in
          
          if let error = err{
              
              self.errorMsg = error.localizedDescription
              withAnimation{ self.error.toggle()}
              return
          }
        
          UserDefaults.standard.set(authVerificationId, forKey: "authVerificationID")
//          let authVerificationId = UserDefaults.standard.string(forKey: "authVerificationID")
          self.authVerificationId = authVerificationId ?? ""
          self.gotoVerify = true
      }
    }
    
    func verifyCode(onSuccess: @escaping() -> Void) {
      
      let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.authVerificationId ?? "", verificationCode: code)
      
      loading = true
      
      Auth.auth().signIn(with: credential) { (result, err) in
          
          self.loading = false
          
          if let error = err{
              self.errorMsg = error.localizedDescription
              withAnimation{ self.error.toggle()}
              return
          }
          
          // else user logged in Successfully ....
          
          withAnimation{self.status = true}
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

