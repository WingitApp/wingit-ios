//
//  InviteCodeInputField.swift
//  wingit4
//
//  Created by Daniel Yee on 10/18/21.
//

import SwiftUI


struct InviteCodeInputField: View {
    
    @Binding var inviteCode: String
    
    var body: some View {
       
    TextField("Invite code", text: $inviteCode)
        .modifier(TextFieldModifier())
    }
}
