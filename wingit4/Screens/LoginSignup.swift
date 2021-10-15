//
//  LoginSignup.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct LoginSignup: View {
  
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    var body: some View {
      VStack(spacing: 10){
        Image("logo")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 40, height: 40)
          .padding(.bottom, 50)
        
             Button(action: { withAnimation(.easeIn){
     
               signupViewModel.index = 1 }  })
        {
               Text("Sign Up")
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
            .background(Color.wingitBlue)
            .cornerRadius(5)
        }
        
        
          Button(action: { withAnimation(.easeIn){

            signupViewModel.index = 6
            
          }}){
            Text("Login")
              .bold()
              .foregroundColor(.wingitBlue)
              .padding()
              }
        
           }
    }
}

struct LoginSignup_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignup()
    }
}
