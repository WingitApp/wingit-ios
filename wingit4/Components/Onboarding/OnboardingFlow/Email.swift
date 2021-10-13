//
//  Email.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Email: View {
  
  @EnvironmentObject var session: SessionStore
  @ObservedObject var signupViewModel = SignupViewModel()
  
    var body: some View {
      
      VStack(alignment: .leading, spacing: 5){
       Text("Email").bold().font(.title).padding(.bottom, 25)
        EmailTextField(
          email: $signupViewModel.email
        )
        
        NextButton()
        
      }.padding()
      
    }
}
