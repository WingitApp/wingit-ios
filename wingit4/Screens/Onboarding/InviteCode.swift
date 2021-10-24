//
//  InviteCode.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct InviteCode: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func submitCode() {
    if signupViewModel.inviter == nil {
      signupViewModel.verifyCode()
    } else {
      withAnimation(.easeIn) {
        signupViewModel.index = .emailSignup
      }
    }
  }
  
    var body: some View {
      VStack{
        if (signupViewModel.inviter != nil) {
          Text("\(signupViewModel.inviter?.displayName ?? "Your friend") invited you to Wingit")
            .font(.caption)
          URLImageView(urlString: signupViewModel.inviter?.profileImageUrl)
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .padding(20)
        }
        InviteCodeInputField(inviteCode: $signupViewModel.inviteCode)
          .padding(.horizontal, 25)
        Image("gift")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 75, height: 75)
          .padding(.top, 50)
        Spacer()
        HStack{
          Spacer()
          Button(action: submitCode)
          { NextButton()}
        }
      }
      .alert(isPresented: $signupViewModel.isAlertShown) {
        Alert(title: Text("Error"),
              message: Text(self.signupViewModel.errorString),
              dismissButton: .default(Text("OK"))
        )
      }
      .sheet(
        isPresented: $signupViewModel.inviterSheetOpen,
        content: {
          Invitation(inviter: signupViewModel.inviter)
        })
      .onTapGesture(perform: dismissKeyboard)
    }
  }
  
