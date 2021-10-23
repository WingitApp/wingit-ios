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
     
        
      VStack {
        
        if signupViewModel.index == 0 {
          LoginSignup()
            .environmentObject(signupViewModel)
          
        }
        
        else if signupViewModel.index == 1 {
          
            SignUpTitles(title: "Welcome! Enter invite code",
                         subtitle: "You need an invite code from a Wingit user to join!").padding(.bottom, 30)
            InviteCode()
              .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 2 {
          
          ZStack {
          Tab()
            .environmentObject(signupViewModel)
          PhoneNumber()
            .environmentObject(signupViewModel)
            .environmentObject(phoneViewModel)
          }
          
        } else if signupViewModel.index == 3 {
          
          Tab()
            .environmentObject(signupViewModel)
          VerifyPhoneNumber()
            .environmentObject(signupViewModel)
            .environmentObject(phoneViewModel)
          
        } else if signupViewModel.index == 4 {
       
          Tab()
            .environmentObject(signupViewModel)
          
            SignUpTitles(title: "Welcome!",
                         subtitle: "Let’s create an account to get started.")
            EmailPass()
              .environmentObject(signupViewModel)
          
          
        } else if signupViewModel.index == 5 {
          
          Tab()
            .environmentObject(signupViewModel)
            SignUpTitles(title: "Names",
                         subtitle: nil)
            Names()
              .environmentObject(signupViewModel)
          
          
        }
        else if signupViewModel.index == 6 {
          //Optional
          
          Tab()
            .environmentObject(signupViewModel)
          
          SignUpTitles(title: "Add a photo and bio",
                       subtitle: "Help your friends identify you better.")
            AvatarBio()
              .environmentObject(signupViewModel)
          
          
        } else if signupViewModel.index == 7 {
          //Optional
         LoginScreen()
            .environmentObject(signupViewModel)
          
        } else if signupViewModel.index == 8 {
          EmailLogin()
        } 
        
      }
      .onAppear {
        if (signupViewModel.inviter == nil && !signupViewModel.inviterId.isEmpty) {
          signupViewModel.fetchInviter(inviterId: signupViewModel.inviterId)
          signupViewModel.inviteCode = String(signupViewModel.inviterId.prefix(6))
        }
      }
      .onChange(of: deepLink) { deepLink in
        guard let deepLink = deepLink else { return }
        switch deepLink {
        case .invite(let inviterId):
          signupViewModel.fetchInviter(inviterId: inviterId)
        case .home:
          break
        }
      }
    }
  }
}

struct Tab: View {

  @EnvironmentObject var signupViewModel: SignupViewModel
  @Namespace var name
  
    var body: some View {
      
      VStack {
      HStack(spacing: 0) {
        
        
        Button(action: {
          
          withAnimation(.spring()){
            
            signupViewModel.index = 2
          }
          
        }) {
          
          VStack {
            
            Text("Phone")
              .font(.caption2)
              .foregroundColor(signupViewModel.index == 2 ? .black : .gray)
            
            ZStack {
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 3)
              
              if signupViewModel.index == 2{
                
                Capsule()
                  .fill(Color.wingitBlue)
                  .frame( height: 3)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
        }
    
        Button(action: {
          
          withAnimation(.spring()){
            
            signupViewModel.index = 4
          }
          
        }) {
          
          VStack {
            
            Text("Email/Pass")
              .font(.caption2)
              .foregroundColor(signupViewModel.index == 4 ? .black : .gray)
            
            ZStack {
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 3)
              
              if signupViewModel.index == 4 {
                
                Capsule()
                  .fill(Color.wingitBlue)
                  .frame( height: 3)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
        }
        Button(action: {
          
          withAnimation(.spring()){
            
            signupViewModel.index = 5
          }
          
        }) {
          
          VStack {
            
            Text("Names")
              .font(.caption2)
              .foregroundColor(signupViewModel.index == 5 ? .black : .gray)
            
            ZStack {
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 3)
              
              if signupViewModel.index == 5 {
                
                Capsule()
                  .fill(Color.wingitBlue)
                  .frame( height: 3)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
        }
        Button(action: {
          
          withAnimation(.spring()){
            
            signupViewModel.index = 6
          }
          
        }) {
          
          VStack {
            
            Text("Photo/Bio")
              .font(.caption2)
              .foregroundColor(signupViewModel.index == 6 ? .black : .gray)
            
            ZStack {
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 3)
              
              if signupViewModel.index == 6 {
                
                Capsule()
                  .fill(Color.wingitBlue)
                  .frame( height: 3)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
        }
      }
        Spacer()
    }
      .padding(.top,30)
    }
}

