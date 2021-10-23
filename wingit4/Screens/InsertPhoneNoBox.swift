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
//    self.phoneViewModel.sendCode {
//      DispatchQueue.main.async {
        withAnimation(.easeIn) {
          signupViewModel.index = 3
        }
//      }
//    }
  }
  
    var body: some View {
      
      ZStack {
        
        ProgressNumberView()
          .environmentObject(signupViewModel)
        
          VStack(alignment: .leading, spacing: 15){
            
//            Tab(width: 75, index: 2, title: "Phone")
//            Tab()
            
            ProgressBar(percent: 0)
          
//            .environmentObject(signupViewModel)
            
//          Text("Provide a phone number").bold().font(.title2)
//          Text("You’ll receive a login code for better security.").font(.caption).foregroundColor(.gray)
//              .padding(.top, 25)
          Spacer()
            
          }

      VStack{
      HStack{
          
          VStack(alignment: .leading, spacing: 6) {
              
              Text("Enter your number")
                  .font(.caption)
                  .foregroundColor(.gray)
              
              Text("+ \(phoneViewModel.getCountryCode())  \(phoneViewModel.phoneNo)")
                  .font(.title2)
                  .fontWeight(.bold)
                  .foregroundColor(.black)
          }.padding(.leading)
          
          Spacer(minLength: 0)
          
        Button(action: sendCode) {
            Text("Send").padding(.horizontal)
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
