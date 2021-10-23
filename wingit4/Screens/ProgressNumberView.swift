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

        ProgressNumber(index: 2, page: "1", title: "Phone")
        ProgressNumber(index: 4, page: "2", title: "Email/Pass")
        ProgressNumber(index: 5, page: "3", title: "Names")
        ProgressNumber(index: 6, page: "4", title: "Photo/Bio")
        
      
      }.padding(.horizontal, 10)
        Spacer()
    }
      .padding(.top, 37)
    }
}


