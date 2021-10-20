//
//  InviteCode.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct InviteCode: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
    var body: some View {
      VStack{
        Spacer()
      InviteCodeInputField(inviteCode: $signupViewModel.inviteCode)
          .padding(.horizontal,25)
        Image("gift")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 75, height: 75)
          .padding(.top, 50)
        Spacer()
        HStack{
          Spacer()
        Button(action: { withAnimation(.easeIn){
          signupViewModel.index = 2} })
        { NextButton()}
        }
      }
      .onTapGesture(perform: dismissKeyboard)
    }
}

