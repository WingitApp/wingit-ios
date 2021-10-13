//
//  FirstLastName.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct FirstLastName: View {
  
  @EnvironmentObject var session: SessionStore
  @ObservedObject var signupViewModel = SignupViewModel()
  //Appstorage
  
    var body: some View {
      
      VStack(alignment: .leading, spacing: 5){
        Text("Name").bold().font(.title).padding(.bottom, 25)
        FirstNameTextField(
          firstName: $signupViewModel.firstName
        )
        LastNameTextField(
          lastName: $signupViewModel.lastName
        )
        
        NextButton()
        
      }.padding()
    }
}

