//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI
import FirebaseAuth

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
  @ObservedObject var phoneViewModel = PhoneViewModel()

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
       
          VStack{
            Spacer()
         ReferralCode()
            .environmentObject(signupViewModel)
            Spacer()
            HStack{
              Spacer()
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 2} })
            { NextButton()}
            }
          }
          
        } else if signupViewModel.index == 2 {
          
          VStack{
            Spacer()
            EmailPass()
              .environmentObject(signupViewModel)
            Spacer()
            HStack{
              Spacer()
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 3} })
            { NextButton()}
            }
          }
      
        } else if signupViewModel.index == 3 {
          
         PhoneNumber()
            .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 4 {
          
          Verification(phoneViewModel: phoneViewModel)
             .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 5 {
          
          VStack{
            Spacer()
            Names()
              .environmentObject(signupViewModel)
            Spacer()
            HStack{
              Spacer()
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 6} })
            { NextButton()}
            }
          }
        }
        else if signupViewModel.index == 6 {
        
          VStack{
            Spacer()
            UploadAvatar()
              .environmentObject(signupViewModel)
            Spacer()
            HStack{
              Spacer()
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 7} })
            { NextButton()}
            }
          }

        } else if signupViewModel.index == 7 {
          VStack{
            Spacer()
            Bio()
              .environmentObject(signupViewModel)
            Spacer()
            HStack{
              Spacer()
            Button(action: { withAnimation(.easeIn){
              signupViewModel.index = 7} })
            { NextButton()}
            }
          }
        } else if signupViewModel.index == 8 {
           Login1()
        }
        
      }
      
    }
    
    
    
  }
}
