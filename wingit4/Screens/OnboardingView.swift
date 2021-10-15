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

         LoginSignup()
            .environmentObject(signupViewModel)
          
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
          
         
            EmailPass()
              .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 3 {
          
         PhoneNumber()
            .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 4 {
          
          Verification(phoneViewModel: phoneViewModel)
             .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 5 {
         
            Names()
              .environmentObject(signupViewModel)
           
        }
        else if signupViewModel.index == 6 {
        //Optional
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
          //Optional
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
