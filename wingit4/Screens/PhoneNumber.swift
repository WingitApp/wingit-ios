//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct PhoneNumber : View {
  
  @StateObject var phoneViewModel = PhoneViewModel()
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    
  func sendCode(){
    withAnimation(.easeIn){
      signupViewModel.index = 4}
    self.phoneViewModel.sendCode()
    self.phoneViewModel.gotoVerify = true
  }
  
    var body: some View{
//      SignUpTitles(title: "Provide a phone number",
//                   subtitle: "You’ll receive a login code for better security.")
      ZStack{
          
          VStack{
       
              
            VStack(alignment: .leading){
            
                  // Mobile Number Field....
              InsertPhoneNoBox()
                .environmentObject(signupViewModel)
              
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                      .background(Color.white)
                      .cornerRadius(20)
            
              // Custom Number Pad....
              
              CustomNumberPad(value: $phoneViewModel.phoneNo, isVerify: false)
              
          }
          .background(Color("lightGray").ignoresSafeArea(.all, edges: .bottom))
          
          if phoneViewModel.error{
              
              PhoneAlertView(msg: phoneViewModel.errorMsg, show: $phoneViewModel.error)
          }
      }
    }
}
