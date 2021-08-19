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
      

    var body: some View {
        NavigationView {
            VStack {
               Spacer()
               HeaderView()
               Spacer()
               Divider()
               EmailTextField(email: $signinViewModel.email)
               PasswordTextField(password: $signinViewModel.password)
               SigninButton(
                action: signinViewModel.signin,
                label: TEXT_SIGN_IN
               ).alert(isPresented: $signinViewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(self.signinViewModel.errorString),
                        dismissButton: .default(Text("OK"))
                    )
                }
               Divider()
               NavigationLink(destination: SignupView()) {
                 SignupText()
               }
            }.onTapGesture(perform: dismissKeyboard)
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

