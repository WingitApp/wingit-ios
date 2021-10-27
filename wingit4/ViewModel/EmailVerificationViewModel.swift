//
//  emailVerificationViewModel.swift
//  wingit4
//
//  Created by Amy Chun on 10/26/21.
//

import SwiftUI
import FirebaseAuth

class EmailVerificationViewModel: ObservableObject {
  
  @Published var verifyEmail: Bool = false
  @Published var emailIsVerified: Bool = false
  

  func checkIfEmailIsVerified() {
    Auth.auth().currentUser?.reload(completion: { error in
      if error == nil {
        if Auth.auth().currentUser!.isEmailVerified {
          self.emailIsVerified = true
      }
      }
    })
  
  }
  
  func sendEmailVerification() {
    
    Auth.auth().currentUser?.sendEmailVerification { (error) in
            if error != nil {
              print(error!.localizedDescription)
              return
            }
        return
//        print("user email verification sent.")
      
    }
  }
  
 
  
}
