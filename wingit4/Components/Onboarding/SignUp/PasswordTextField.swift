//
//  PasswordTextField.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI


struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
       
    SecureField("Password", text: $password)
        .modifier(TextFieldModifier())
    }
}
