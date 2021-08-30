//
//  SignUpFirstView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/30/21.
//

import SwiftUI

struct SignUpFirst: View {
    
    @ObservedObject var signupViewModel = SignupViewModel()
    
    var body: some View {
        VStack{
            UsernameTextField(
              username: $signupViewModel.username
            )
            FirstNameTextField(
                firstName: $signupViewModel.firstName
              )
            LastNameTextField(
                lastName: $signupViewModel.lastName
              )
        }
    }
}


///Need to either merge new data in the same collection or create a new one in the new database we're planning on using. 
