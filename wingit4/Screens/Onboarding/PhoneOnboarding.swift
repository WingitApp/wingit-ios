//
//  PhoneOnboarding.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct PhoneOnboarding : View {
  @Binding var signupInProgress: Bool
  @EnvironmentObject var phoneViewModel: PhoneViewModel
  @EnvironmentObject var signupViewModel: SignupViewModel
  
    var body: some View{
          VStack{
            VStack(alignment: .leading){
              InsertPhoneNoBox(signupInProgress: $signupInProgress)
                .environmentObject(signupViewModel)
                .environmentObject(phoneViewModel)
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                      .background(Color.white)
                      .cornerRadius(5)
              CustomNumberPad(value: $phoneViewModel.phoneNumber, isVerify: false)
              
          }
          .background(Color("lightGray").ignoresSafeArea(.all, edges: .bottom))
          .alert(isPresented: $phoneViewModel.alertShown) {
            Alert(title: Text(phoneViewModel.alertError ? TEXT_ERROR : TEXT_SUCCESS),
                  message: Text(phoneViewModel.alertMessage),
                  dismissButton: .default(Text("OK"))
            )
          }
      
    }
}
