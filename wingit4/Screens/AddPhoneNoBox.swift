//
//  AddPhoneNoBox.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI

struct AddPhoneNoBox: View {
  
  @StateObject var phoneViewModel = PhoneViewModel()
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    var body: some View {
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
          
      }
      .frame(width: 350, height: 75)
      .background(Color.white)
      .cornerRadius(20)
      .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0)
      .padding()
        
        HStack{
          Spacer()
        Button(action: {  withAnimation(.easeIn){
          signupViewModel.index = 4}},
                  //sendCode,
                 label: {
                NextButton()
          })
          .disabled(phoneViewModel.phoneNo == "" ? true : false)
        }.padding(.vertical)
      }
    }
}

