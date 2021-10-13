//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI

struct OnboardingView: View {
  
  
    var body: some View {
        // For Smaller Size iPhones...
        
       
        VStack{
          
            
            if UIScreen.main.bounds.height < 750{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    FirstView()
                }
            }
            else{
                
                   FirstView()
            }
        }
        .padding(.vertical)
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
          .background(Color.white)
          .ignoresSafeArea()
        
    }
}

struct FirstView : View {
  
  @EnvironmentObject var session: SessionStore
 // @State var index = 0
 // @Namespace var name
  @StateObject var signupViewModel = SignupViewModel()
  @ObservedObject var loginViewModel = LoginViewModel()

  var body: some View{
    ActivityIndicatorView(message: "Loading...", isShowing: self.$session.isSessionLoading) {
      VStack{
        
        if signupViewModel.index == 0{

          VStack{
            Image("logo")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 40, height: 40)
            
                 Button(action: { withAnimation(.easeIn){
         
                   signupViewModel.index = 6
                 }}){
                   Text("Login")
                 }
                 Button(action: { withAnimation(.easeIn){
         
                   signupViewModel.index = 1 }  })
            {
                   Text("Sign Up")
                 }
               }
        }
        
        else if signupViewModel.index == 1 {
          ZStack{
          Button(action: { withAnimation(.easeIn){
            signupViewModel.index = 2} })
          { NextButton()}
            
          SignUp1()
            .environmentObject(signupViewModel)
            
          }
        } else if signupViewModel.index == 2 {
          ZStack{
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 3} })
            { NextButton()}
            .disabled(signupViewModel.password == "" ? true : false)
            
          SignUp2()
            .environmentObject(signupViewModel)
          }
        } else if signupViewModel.index == 3 {
          ZStack{
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 4} })
            { NextButton()}
            SignUp3()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 4 {
          
           PhoneNumber()
             .environmentObject(signupViewModel)
        } else if signupViewModel.index == 5 {
          
        //  Verification(loginViewModel: loginViewModel)
        }
        else if signupViewModel.index == 6 {
          
          Login1()
        }
      }
      
    }
    
    
    
  }
}
