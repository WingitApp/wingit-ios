//
//  Login1.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct EmailLogin : View {
    
    @StateObject var signinViewModel = SigninViewModel()
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                VStack(alignment: .center, spacing: 12) {
                    
                    Text("Welcome Back")
                        .fontWeight(.bold)
                    
                }
                
      
            }
            .padding(.horizontal,25)
            .padding(.top,30)
            
            VStack(alignment: .leading, spacing: 35) {
            
                EmailTextField(email: $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
                
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            // Login Button....
            
            SigninButton(
             action: signinViewModel.signin,
             label: TEXT_LOGIN
            )
            .padding(.horizontal,25)
            .padding(.top,25)
            .alert(isPresented: $signinViewModel.isAlertShown) {
                 Alert(
                     title: Text("Something went wrong..."),
                     message: Text(self.signinViewModel.errorString),
                     dismissButton: .default(Text("OK"))
                 )
             }
        }
        .environmentObject(signinViewModel)
        .onTapGesture(perform: dismissKeyboard)
        .onAppear{
          logToAmplitude(event: .viewLoginScreen)
        }
    }
}
