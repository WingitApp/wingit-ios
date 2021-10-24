//
//  SignUp1.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct Names : View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var signupViewModel: SignupViewModel
    
  func addUserNames() {
    withAnimation(.easeIn) {
      signupViewModel.index = .bio
    }
//    signupViewModel.addUserNames() { user in
//      signupViewModel.onSignupSuccess(user: user)
//      self.session.currentUser = user
//    }
  }
  
    var body: some View{
        
      VStack{
        Spacer()
        NameTextField()
          .environmentObject(signupViewModel)
        Spacer()
        HStack{
          Spacer()
          Button(action: { addUserNames() })
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

struct NameTextField : View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var signupViewModel: SignupViewModel
    
    var body: some View{
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                FirstNameTextField(
                  firstName: $signupViewModel.firstName
                )
            
                LastNameTextField(
                  lastName: $signupViewModel.lastName
                )
                }
                UsernameTextField(
                  username: $signupViewModel.username
                )
            }
            .padding(.horizontal,25)
            .padding(.top,25)

        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
    }
}
