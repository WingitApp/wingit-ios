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
    
     var username: String = ""
     var bio: String = ""
     var email: String = ""
     var password: String = ""
     var image: Image = Image(IMAGE_USER_PLACEHOLDER)
     var imageData: Data = Data()
     var errorString = ""
     //var handle: AuthStateDidChangeListenerHandle?
    
     @Published var Agreed = false
     @Published var showImagePicker: Bool = false
     @Published var showAlert: Bool = false
     @Published var showscreen: Bool = false
     @Environment (\.presentationMode) var presentationMode
//
    
 
    func signup(username: String, bio: String, email: String, password: String, imageData: Data, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !username.isEmpty && !bio.isEmpty && !email.isEmpty && !password.isEmpty && !imageData.isEmpty {
           // showscreen.toggle()
            AuthService.signupUser(username: username, bio: bio, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
        }
        else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
    }
    
    func disagree(){
        showAlert = true
        errorString = "Please agree in order to proceed."
    }
    
    func agree(userId: String){
        Ref.FIRESTORE_DOCUMENT_AGREED(userId: userId).setData(["Agreed": userId])
    }
    
//    func checkAgreed(){
//        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
//            if let user = user {
//                Ref.FIRESTORE_DOCUMENT_AGREED(userId: user.uid).getDocument { (document, error) in
//           if let doc = document, doc.exists {
//               self.Agreed = true
//           }
//       }
//       self.Agreed = true
//    }
//    })
// }
    
}
