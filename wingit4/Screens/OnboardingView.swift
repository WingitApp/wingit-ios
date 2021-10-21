//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import Firebase
import FirebaseAuth
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
  // deepLink to listen to
  @Environment(\.deepLink) var deepLink
  @EnvironmentObject var session: SessionStore
  // @State var index = 0
  // @Namespace var name
  @StateObject var signupViewModel = SignupViewModel()
  @StateObject var phoneViewModel = PhoneViewModel()
  
  var body: some View{
    ActivityIndicatorView(message: "Loading...", isShowing: self.$session.isSessionLoading) {
      
      VStack{
        
        if signupViewModel.index == 0 {
          
          LoginSignup()
            .environmentObject(signupViewModel)
          
        }
        
        else if signupViewModel.index == 1 {
          
          ZStack{
            SignUpTitles(title: "Hi! Enter your invite code",
                         subtitle: "An invite code from a current user is required to signup for Wingit.").padding()
            InviteCode()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 2 {
          
          
          ZStack{
            SignUpTitles(title: "Welcome!",
                         subtitle: "Let’s create an account to get started.")
            EmailPass()
              .environmentObject(signupViewModel)
          }
        } else if signupViewModel.index == 3 {
         
          PhoneNumber()
            .environmentObject(signupViewModel)
            .environmentObject(phoneViewModel)
          
        } else if signupViewModel.index == 4 {
          VerifyPhoneNumber()
            .environmentObject(signupViewModel)
            .environmentObject(phoneViewModel)
          
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
          SignUpTitles(title: "Add a photo and bio",
                       subtitle: "Help your friends identify you better.")
            AvatarBio()
              .environmentObject(signupViewModel)
          }
          
        } else if signupViewModel.index == 7 {
          //Optional
         Login1()
          
        }
        
      }
      // Define navigation
      // 1
      .onChange(of: deepLink) { deepLink in
        guard let deepLink = deepLink else { return }
        switch deepLink {
        case .invite(let inviterId):
          signupViewModel.fetchInviter(inviterId: inviterId)
        case .home:
          break
        }
      }
      .sheet(
        isPresented: $signupViewModel.inviterSheetOpen,
        content: {
          Invitation(inviter: signupViewModel.inviter)
        })
    }
  }
}
