//
//  LoginSignup.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI
//import FirebaseUI/Auth

struct SignupOrLogin: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
  @Binding var signupInProgress: Bool
    var body: some View {
      
      VStack(spacing: 10){
        Image("logo")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 40, height: 40)
          .padding(.bottom, 50)
        
             Button(action: { withAnimation(.easeIn){
               signupViewModel.index = .inviteCode }  })
        {
               Text("Sign Up")
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
            .background(Color.wingitBlue)
            .cornerRadius(5)
        }
        
        
          Button(action: { withAnimation(.easeIn){
            signupViewModel.index = .loginMethod
          }}){
            Text("Login")
              .bold()
              .foregroundColor(.wingitBlue)
              .padding()
              }
        
           }
      .onAppear {
        signupInProgress = true
      }
    }
}
