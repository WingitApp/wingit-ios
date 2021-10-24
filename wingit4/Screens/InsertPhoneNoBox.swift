//
//  AddPhoneNoBox.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct InsertPhoneNoBox: View {
  
  @EnvironmentObject var phoneViewModel: PhoneViewModel
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func sendCode() {
    withAnimation(.easeIn) {
      signupViewModel.index = .phoneVerify
    }
  }
  
    var body: some View {
      
      ZStack {
        ProgressBar(percent: 0)
        ProgressNumberView()
          .environmentObject(signupViewModel)
        SignUpTitles(title: "Provide a phone number",
                     subtitle: "Enter a phone number for better security")
          VStack(alignment: .leading, spacing: 15){
          Spacer()
          }

      VStack{
   
      HStack{
          VStack(alignment: .leading, spacing: 6) {
              Text("+ \(phoneViewModel.getCountryCode())  \(phoneViewModel.phoneNo)")
                  .font(.title2)
                  .fontWeight(.bold)
                  .foregroundColor(.black)
          }.padding(.leading)
          
          Spacer(minLength: 0)
          
        Button(action: sendCode) {
            Text("Send").padding(.horizontal)
            .foregroundColor(Color.wingitBlue)
        }.disabled(phoneViewModel.phoneNo == "" ? true : false)
        
      }
      .padding(10)
      .background(Color.white)
      .cornerRadius(5)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(Color.borderGray, lineWidth: 1)
      )
//      .frame(width: 380, height: 75)
  
      }
      .padding(.horizontal,25)
    }
    }
}



//  .padding()
//  .background(Color.white)
//  .cornerRadius(5)
//  .overlay(
//    RoundedRectangle(cornerRadius: 5)
//      .stroke(Color.borderGray, lineWidth: 1)
//  )
