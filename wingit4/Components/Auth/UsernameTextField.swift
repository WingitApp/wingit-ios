//
//  UsernameTextField.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct UsernameTextField: View {
      @Binding var username: String
     
     var body: some View {
         HStack {
             Image(systemName: "person.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
             TextField(TEXT_USERNAME, text: $username)
         }.modifier(TextFieldModifier())
     }
}

