//
//  LoginViewModel.swift
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
    
    // Loading View....
    @Published var loading = false
    
    func getCountryCode()->String{
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
    
    
    // sending Code To User....
    
    func sendCode(){
        
        // enabling testing code...
        // disable when you need to test with real device...
//      user.multiFactor.getSessionWithCompletion({ (session, error) in
//        // ...
//      })
    //  user.multiF
      Auth.auth().settings?.isAppVerificationDisabledForTesting = false
//        let user = Auth.auth().currentUser
//        let phoneNumber = "+\(getCountryCode())\(phoneNo)"
//
//      user?.multiFactor.getSessionWithCompletion({(session, error) in
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil, multiFactorSession: session)
//          { (verificationId, error) in
//
//          let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId!,
//                                                                   verificationCode: self.CODE)
//
//          let assertion = PhoneMultiFactorGenerator.assertion(with: credential)
//          user?.multiFactor.enroll(with: assertion, displayName: user?.displayName) {(error) in
//            self.errorMsg = error?.localizedDescription ?? ""
//          }
//
//        }
//      })
      
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        let number = "+\(getCountryCode())\(phoneNo)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            
            if let error = err{
                
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode(){
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
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
    
    func requestCode(){
        
        sendCode()
        withAnimation{
            
            self.errorMsg = "Code Sent Successfully !!!"
            self.error.toggle()
        }
    }
}

