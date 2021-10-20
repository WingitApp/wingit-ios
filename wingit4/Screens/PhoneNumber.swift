//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct PhoneNumber : View {
  
  @EnvironmentObject var phoneViewModel: PhoneViewModel
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    var body: some View{
//      SignUpTitles(title: "Provide a phone number",
//                   subtitle: "You’ll receive a login code for better security.")
      ZStack{
          
          VStack{
       
              
            VStack(alignment: .leading){
            
                  // Mobile Number Field....
              InsertPhoneNoBox()
                .environmentObject(signupViewModel)
                .environmentObject(phoneViewModel)
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                      .background(Color.white)
                      .cornerRadius(5)
            
              // Custom Number Pad....
              
              CustomNumberPad(value: $phoneViewModel.phoneNo, isVerify: false)
              
          }
          .background(Color("lightGray").ignoresSafeArea(.all, edges: .bottom))
          .alert(isPresented: $phoneViewModel.error){
            Alert(title: Text("Error"),
                  message: Text(self.phoneViewModel.errorMsg),
                  dismissButton: .default(Text("OK"))
            )
          }
      }
    }
}
