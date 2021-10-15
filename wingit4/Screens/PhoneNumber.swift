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
        
      ZStack{
          
          VStack{
              
            VStack(alignment: .leading){
                  
                  Text("What's your phone number?")
                      .bold().font(.title)
                      .padding(.leading)
                  
                  
                  Text("You'll receive a 4 digit code to verify next.")
                      .bold()
                      .font(.caption2)
                      .foregroundColor(.gray)
                      .padding()
                  
                  // Mobile Number Field....
              AddPhoneNoBox(phoneViewModel: phoneViewModel)
                .environmentObject(signupViewModel)
              
                  }
                  .frame(height: UIScreen.main.bounds.height / 1.8)
                  .background(Color.white)
                  .cornerRadius(20)
           
              // Custom Number Pad....
              
              CustomNumberPad(value: $phoneViewModel.phoneNo, isVerify: false)
              
          }
          .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
          
          if phoneViewModel.error{
              
              PhoneAlertView(msg: phoneViewModel.errorMsg, show: $phoneViewModel.error)
          }
      }
    }
}
