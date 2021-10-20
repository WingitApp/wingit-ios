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
      .sheet(
        isPresented: $signupViewModel.inviterSheetOpen,
        content: {
          Invitation(inviter: signupViewModel.inviter)
      })
      .onOpenURL { url in
        print("Incoming URL parameter is: \(url)")
          // 2
          let linkHandled = DynamicLinks.dynamicLinks()
            .handleUniversalLink(url) { dynamicLink, error in
            guard error == nil else {
              fatalError("Error handling the incoming dynamic link.")
            }
            // 3
            if let dynamicLink = dynamicLink {
              // Handle Dynamic Link
//              handleDynamicLink(dynamicLink)
            }
          }
          // 4
          if linkHandled {
            print("Link Handled")
          } else {
            print("No Link Handled")
          }
      }
    }
    
    
    
  }
}
