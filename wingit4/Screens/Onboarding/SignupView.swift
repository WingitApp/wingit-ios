//
//  SignupView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct SignupView : View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var signupViewModel = SignupViewModel()
    
    var body: some View{
        
        VStack{
           
            
            VStack(alignment: .leading, spacing: 15) {
                
                HStack{
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
                EmailTextField(
                  email: $signupViewModel.email
                )
                PasswordTextField(
                  password: $signupViewModel.password
                )
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            
            SignupButton(
                action: {
                    signupViewModel.signup() { user in
                        signupViewModel.onSignupSuccess(user: user)
                        self.session.currentUser = user
                    }
                },
              label: TEXT_SIGN_UP
            )
            .padding(.horizontal,25)
            .padding(.top,25)
            .alert(
              isPresented: $signupViewModel.isAlertShown
            ) {
                Alert(
                  title: Text("Error"),
                  message: Text(self.signupViewModel.errorString),
                  dismissButton: .default(Text("OK"))
                )
            }
            
            Text("By signing up, you agree to the").padding(.top, 10)
              .modifier(CaptionStyle())
            EULA()
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }

    }
}

struct EULA: View {
    var body: some View {
        HStack{
            LINK_TERMS_OF_SERVICE.modifier(LinkStyle())
            Text("and").modifier(CaptionStyle())
            LINK_PRIVACY_POLICY.modifier(LinkStyle())
        }
    }
}
