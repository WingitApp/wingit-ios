//
//  Username.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Username: View {
  
  @EnvironmentObject var session: SessionStore
  @ObservedObject var signupViewModel = SignupViewModel()
  
    var body: some View {
      VStack(alignment: .leading, spacing: 5){
       Text("Username").bold().font(.title).padding(.bottom, 25)
        UsernameTextField(
          username: $signupViewModel.username
        )
        
        NextButton()
        
      }.padding()
    }
}
