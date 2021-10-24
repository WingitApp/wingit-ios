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
  
  func emailSignup() {
//    signupViewModel.emailSignup() { user in
//        signupViewModel.onSignupSuccess(user: user)
//        self.session.currentUser = user
    withAnimation(.easeIn) {
      signupViewModel.index = 5}
   
//    }
  }
  
  var body: some View {
    VStack{
      Spacer()
      Image("logo")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 75, height: 75)
        .padding(.bottom, 50)
      EmailPassTextField()
        .environmentObject(signupViewModel)
      Spacer()
      HStack{
        Spacer()
      Button(action: emailSignup)
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
           
       
          
                EmailTextField(
                  email: $signupViewModel.email
                )
                PasswordTextField(
                  password: $signupViewModel.password
                )
              
        
              
          }
            .padding(.top,25)
            .padding(.horizontal,25)
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
    }
}



