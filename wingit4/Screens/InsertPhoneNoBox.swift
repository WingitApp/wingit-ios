//
//  AddPhoneNoBox.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct InsertPhoneNoBox: View {
  
  @StateObject var phoneViewModel = PhoneViewModel()
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func sendCode(){
    self.phoneViewModel.sendCode()
    self.phoneViewModel.gotoVerify = true
    withAnimation(.easeIn){
      signupViewModel.index = 4}
  }
  
  
    var body: some View {
      ZStack{
        
          VStack(alignment: .leading, spacing: 15){
          Text("Provide a phone number").bold().font(.title2)
          Text("You’ll receive a login code for better security.").font(.caption).foregroundColor(.gray)
          Spacer()
          }.padding(.top, 50)

      VStack{
      HStack{
          
          VStack(alignment: .leading, spacing: 6) {
              
              Text("Enter Your Number")
                  .font(.caption)
                  .foregroundColor(.gray)
              
              Text("+ \(phoneViewModel.getCountryCode())  \(phoneViewModel.phoneNo)")
                  .font(.title2)
                  .fontWeight(.bold)
                  .foregroundColor(.black)
          }  .padding(.leading)
          
          Spacer(minLength: 0)
          
        Button(action: { }){
            Text("Send").padding(.horizontal)
        }.disabled(phoneViewModel.phoneNo == "" ? true : false)
      }
      .frame(width: 350, height: 75)
      .background(Color.white)
      .cornerRadius(20)
      .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0)
      .padding()
        
      }
    }
    }
}

