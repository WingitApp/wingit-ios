//
//  Tab.swift
//  wingit4
//
//  Created by Amy Chun on 10/22/21.
//

import SwiftUI

struct ProgressNumberView: View {

  @EnvironmentObject var signupViewModel: SignupViewModel
  @Namespace var name

    var body: some View {

      VStack {
      HStack(spacing: 0) {
        ProgressNumber(index: .emailSignup, page: "1", title: TEXT_EMAIL)
        ProgressNumber(index: .phoneNumber, page: "2", title: TEXT_PHONE)
        ProgressNumber(index: .names, page: "3", title: TEXT_NAME)
        ProgressNumber(index: .bio, page: "4", title: TEXT_BIO)
      }.padding(.horizontal, 10)
        Spacer()
    }
      .padding(.top, 37)
    }
}


