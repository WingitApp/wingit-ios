//
//  ReferralCode.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct ReferralCode: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
    var body: some View {
      VStack{
        Spacer()
      ReferralCodeTextField(referralCode: $signupViewModel.referralCode)
          .padding(.horizontal,25)
        Spacer()
        HStack{
          Spacer()
        Button(action: { withAnimation(.easeIn){
          signupViewModel.index = 2} })
        { NextButton()}
        }
      }
    }
}

