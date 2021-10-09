//
//  SignInButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

struct SigninButton: View {
  @EnvironmentObject var signinViewModel: SigninViewModel
  
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action) {
          if signinViewModel.isPending {
            CircleLoader(size: 20)
          } else {
            Text(label)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(idealWidth: UIScreen.main.bounds.width - 50, maxWidth: 500, minHeight: 55, idealHeight: 55, maxHeight: 55)
                .background( Color("Color"))
                .cornerRadius(5)
          }
       
        }
        .disabled(
          signinViewModel.isPending
        )
        
       // .modifier(SigninButtonModifier())
    }
}
