//
//  BioTextField.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/13/21.
//

import SwiftUI

struct BioTextField: View {
    @Binding var bio: String
   
   var body: some View {
       HStack {
           Image(systemName: "pencil").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
           TextField(TEXT_BIO, text: $bio)
       }.modifier(TextFieldModifier())
   }
}
