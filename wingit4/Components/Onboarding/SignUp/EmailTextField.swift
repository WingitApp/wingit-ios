//
//  EmailTextField.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct EmailTextField: View {
    
    @Binding var email: String
    
    var body: some View {
       
        TextField("Email", text: $email)
        .modifier(TextFieldModifier())
        .disableAutocorrection(true)
    }
}
