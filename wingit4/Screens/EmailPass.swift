//
//  SignUp2.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct EmailPass: View {
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func firstVerification() {
    withAnimation(.easeIn){
      signupViewModel.index = 3}
    signupViewModel.signup() { user in
        signupViewModel.onSignupSuccess(user: user)
        self.session.currentUser = user
    }
  }
  
  var body: some View {
    VStack{
      Spacer()
      EmailPassTextField()
        .environmentObject(signupViewModel)
      Spacer()
      HStack{
        Spacer()
      Button(action: { firstVerification() })
      { NextButton()}
      .alert(
        isPresented: $signupViewModel.isAlertShown
      ) {
          Alert(
            title: Text("Error"),
            message: Text(self.signupViewModel.errorString),
            dismissButton: .default(Text("OK"))
          )
        }
      }
    }
  }
}


struct EmailPassTextField : View {
  
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var signupViewModel: SignupViewModel
    
    var body: some View{
        
        VStack{
            VStack(alignment: .leading, spacing: 15) {
              Text("Email & Password").bold().font(.title).padding(.bottom, 25)
                VStack{
                EmailTextField(
                  email: $signupViewModel.email
                )
                PasswordTextField(
                  password: $signupViewModel.password
                )
            }
              
        
          
          }
            .padding(.top,25)
            .padding(.horizontal,25)
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
    }
}



