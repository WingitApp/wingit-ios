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
      if UIScreen.main.bounds.height < 750 {
        ScrollView(.vertical, showsIndicators: false) {
          OnboardingScreens()
        }
      } else{
        OnboardingScreens()
      }
    }
    .padding(.vertical)
    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
    .background(Color.white)
    .ignoresSafeArea()
  }
}

struct OnboardingScreens : View {
  // deepLink to listen to
  @Environment(\.deepLink) var deepLink
  @EnvironmentObject var session: SessionStore
  @StateObject var signupViewModel = SignupViewModel()
  @StateObject var phoneViewModel = PhoneViewModel()
  @State var percent: CGFloat = 0
  
  var body: some View{
    ActivityIndicatorView(message: "Loading...", isShowing: self.$session.isSessionLoading) {
      VStack {
        if signupViewModel.index == 0 {
          LoginSignup()
        } else if signupViewModel.index == 1 {
          SignUpTitles(title: "Welcome! Enter invite code",
                       subtitle: "You need an invite code from a Wingit user to join!").padding(.bottom, 30)
          InviteCode()
        } else if signupViewModel.index == 2 {
          ZStack {
            ProgressBar(percent: 35)
            ProgressNumberView()
            SignUpTitles(title: "Hang it there.", subtitle: "Enter your email and Password")
            EmailPass()
          }
        } else if signupViewModel.index == 3 {
          ZStack{
            PhoneNumber().environmentObject(phoneViewModel)
          }
        } else if signupViewModel.index == 4 {
          VerifyPhoneNumber().environmentObject(phoneViewModel)
        } else if signupViewModel.index == 5 {
          ZStack {
            ProgressBar(percent: 70)
            ProgressNumberView()
            SignUpTitles(title: "Names", subtitle: nil)
            Names()
          }
        } else if signupViewModel.index == 6 {
          ZStack{
            ProgressBar(percent: 100)
            ProgressNumberView()
            SignUpTitles(title: "Add a photo and bio", subtitle: "Help your friends identify you better.")
            AvatarBio()
          }
        } else if signupViewModel.index == 7 {
          LoginScreen()
        } else if signupViewModel.index == 8 {
          EmailLogin()
        }
      }
      .environmentObject(signupViewModel)
      .onAppear {
        if (signupViewModel.inviter == nil && !signupViewModel.inviterId.isEmpty) {
          signupViewModel.fetchInviter(inviterId: signupViewModel.inviterId)
          signupViewModel.inviteCode = String(signupViewModel.inviterId.prefix(INVITE_CODE_LENGTH))
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
