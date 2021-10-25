//
//  LoginScreen.swift
//  wingit4
//
//  Created by Amy Chun on 10/21/21.
//

import SwiftUI

struct LoginMethod: View {
  @Binding var signupInProgress: Bool
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    var body: some View {
      VStack(alignment: .center, spacing: 20) {
        Button(action: { withAnimation(.easeIn) {
          signupViewModel.index = .loginWithEmail}}) {
        Label("Log in with email", systemImage: "envelope.fill")
              .frame(idealWidth: UIScreen.main.bounds.width - 50, maxWidth: 500, minHeight: 55, idealHeight: 55, maxHeight: 55)
              .background( Color.wingitBlue)
              .cornerRadius(5)
              .foregroundColor(.white)
        }
        
        Button(action: { withAnimation(.easeIn) {
          signupViewModel.index = .phoneNumber}}) {
        Label("Log in with phone", systemImage: "phone.fill")
              .frame(idealWidth: UIScreen.main.bounds.width - 50, maxWidth: 500, minHeight: 55, idealHeight: 55, maxHeight: 55)
              .background( Color.uilightGreen)
              .cornerRadius(5)
              .foregroundColor(.black)
        }
      }.padding()
        .onAppear() {
          signupInProgress = false
        }
    }
}

