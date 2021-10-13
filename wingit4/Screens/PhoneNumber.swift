//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct PhoneNumber : View {
  
  @StateObject var loginViewModel = LoginViewModel()
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  @State var isSmall = UIScreen.main.bounds.height < 750
    
  func sendCode(){
    withAnimation(.easeIn){
      signupViewModel.index = 4}
     
  }
  
    var body: some View{
        
      ZStack{
          
          VStack{
              
              VStack{
                  
                  Text("What's your phone number?")
                      .font(.title2)
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                      .padding()
                  
                  Image("phone")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .padding()
                  
                  Text("You'll receive a 4 digit code\n to verify next.")
                      .font(isSmall ? .none : .title2)
                      .foregroundColor(.gray)
                      .multilineTextAlignment(.center)
                      .padding()
                  
                  // Mobile Number Field....
                  
                  HStack{
                      
                      VStack(alignment: .leading, spacing: 6) {
                          
                          Text("Enter Your Number")
                              .font(.caption)
                              .foregroundColor(.gray)
                          
                          Text("+ \(loginViewModel.getCountryCode())  \(loginViewModel.phoneNo)")
                              .font(.title2)
                              .fontWeight(.bold)
                              .foregroundColor(.black)
                      }
                      
                      Spacer(minLength: 0)
                      
                      NavigationLink(destination: Verification(loginViewModel: loginViewModel),isActive: $loginViewModel.gotoVerify) {
                          
                          Text("")
                              .hidden()
                        
                      }
                      
                      Button(action: loginViewModel.sendCode, label: {
                          
                          Text("Continue")
                              .foregroundColor(.black)
                              .padding(.vertical,18)
                              .padding(.horizontal,38)
                              .background(Color("yellow"))
                              .cornerRadius(15)
                      })
                      .disabled(loginViewModel.phoneNo == "" ? true : false)
                  }
                  .padding()
                  .background(Color.white)
                  .cornerRadius(20)
                  .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
              }
              .frame(height: UIScreen.main.bounds.height / 1.8)
              .background(Color.white)
              .cornerRadius(20)

              // Custom Number Pad....
              
              CustomNumberPad(value: $loginViewModel.phoneNo, isVerify: false)
              
          }
          .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
          
          if loginViewModel.error{
              
              LoginAlertView(msg: loginViewModel.errorMsg, show: $loginViewModel.error)
          }
      }
    }
}
