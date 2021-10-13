//
//  SignUp1.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct SignUp1 : View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var signupViewModel: SignupViewModel
    
    var body: some View{
        
        VStack{
      
            
            VStack(alignment: .leading, spacing: 15) {
                
              Text("Names").bold().font(.title).padding(.bottom, 25) 
              
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
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            
//            SignupButton(
//                action: {
//                    signupViewModel.signup() { user in
//                        signupViewModel.onSignupSuccess(user: user)
//                        self.session.currentUser = user
//                    }
//                },
//              label: TEXT_SIGN_UP
//            )
//            .padding(.horizontal,25)
//            .padding(.top,25)
//            .alert(
//              isPresented: $signupViewModel.isAlertShown
//            ) {
//                Alert(
//                  title: Text("Error"),
//                  message: Text(self.signupViewModel.errorString),
//                  dismissButton: .default(Text("OK"))
//                )
//            }
//
//            Text("By signing up, you agree to the").padding(.top, 10)
//              .modifier(CaptionStyle())
//            EULA()
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
      
    }
}

