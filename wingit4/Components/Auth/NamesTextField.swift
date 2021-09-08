//
//  NamesTextField.swift
//  wingit4
//
//  Created by Daniel Yee on 9/4/21.
//

import SwiftUI

struct FirstNameTextField: View {
      @Binding var firstName: String
     
     var body: some View {
         HStack {
             Image(systemName: "person.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
             TextField(TEXT_FIRST_NAME, text: $firstName)
         }.modifier(TextFieldModifier())
     }
}

struct LastNameTextField: View {
      @Binding var lastName: String
     
     var body: some View {
         HStack {
             Image(systemName: "person.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
             TextField(TEXT_LAST_NAME, text: $lastName)
         }.modifier(TextFieldModifier())
     }
}

struct UsernameTextField: View {
      @Binding var username: String
     
     var body: some View {
         HStack {
             Image(systemName: "person.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
             TextField(TEXT_USERNAME, text: $lastName)
         }.modifier(TextFieldModifier())
     }
}
