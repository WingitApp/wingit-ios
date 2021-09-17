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
        TextField("first name", text: $firstName)
         .modifier(TextFieldModifier())
         .disableAutocorrection(true)
     }
}

struct LastNameTextField: View {
      @Binding var lastName: String
     
     var body: some View {
        TextField("last name", text: $lastName)
         .modifier(TextFieldModifier())
         .disableAutocorrection(true)
     }
}

struct UsernameTextField: View {
      @Binding var username: String
     
     var body: some View {
        TextField("username", text: $username)
         .modifier(TextFieldModifier())
         .disableAutocorrection(true)
     }
}
