//
//  Password.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Password: View {
  
  @EnvironmentObject var session: SessionStore
  @ObservedObject var signupViewModel = SignupViewModel()
  
    var body: some View {
      
      VStack(alignment: .leading, spacing: 5){
       Text("Password").bold().font(.title).padding(.bottom, 25)
        PasswordTextField(
          password: $signupViewModel.password
        )
        
        NextButton()
        
      }.padding()
    }
}
