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
       
          ZStack{
            SignUpTitles(title: "Enter your Referral code",
                         subtitle: nil)
            ReferralCode()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 2 {
          
          
          ZStack{
            SignUpTitles(title: "Email and Password",
                         subtitle: nil)
            EmailPass()
              .environmentObject(signupViewModel)
          }
        } else if signupViewModel.index == 3 {
          
         
          PhoneNumber()
            .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 4 {
          
          Verification(phoneViewModel: phoneViewModel)
             .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 5 {
          ZStack{
          SignUpTitles(title: "Names",
                       subtitle: nil)
            Names()
              .environmentObject(signupViewModel)
          }
        }
        else if signupViewModel.index == 6 {
        //Optional
          ZStack{
          SignUpTitles(title: "Add a profile photo",
                       subtitle: "A profile photo will help your friends identify you.")
            UploadAvatar()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 7 {
          //Optional
          ZStack{
          SignUpTitles(title: "Include a short bio",
                       subtitle: nil)
            Bio()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 8 {
           Login1()
        }
        
      }
      
    }
    
    
    
  }
}
