//
//  ContentView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Amplitude
import SwiftUI

struct SigninView: View {
    
     @ObservedObject var signinViewModel = SigninViewModel()
      
      func signIn() {
        logToAmplitude(event: .loginAttempt)
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            Amplitude.instance().setUserId(user.uid)
            logToAmplitude(event: .userLogin, properties: [.method: "email", .platform: "ios"])
            self.clean()
        }) { (errorMessage) in
           
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
        }

      }
      
      func clean() {
          self.signinViewModel.email = ""
          self.signinViewModel.password = ""
      }
    
    var body: some View {
        NavigationView {
            VStack {
               Spacer()
               HeaderView()
               Spacer()
               Divider()
                EmailTextField(email: $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
               SigninButton(action: signIn, label: TEXT_SIGN_IN).alert(isPresented: $signinViewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(self.signinViewModel.errorString), dismissButton: .default(Text("OK")))
                }
               Divider()
                NavigationLink(destination: SignupView()) {
                 SignupText()
                }
            }.onTapGesture {
                dismissKeyboard()
                
            }
        }.onAppear{
            logToAmplitude(event: .viewLoginScreen)
        }
   
       
    }
}

//struct SigninView_Previews: PreviewProvider {
//    static var previews: some View {
//        SigninView()
//    }
//}

