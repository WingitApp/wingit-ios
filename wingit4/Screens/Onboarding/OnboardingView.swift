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
        if signupViewModel.index == .signupOrLogin {
          SignupOrLogin()
        } else if signupViewModel.index == .inviteCode {
          SignUpTitles(title: "Welcome! Enter invite code",
                       subtitle: "You need an invite code from a Wingit user to join!").padding(.bottom, 30)
          InviteCode()
        } else if signupViewModel.index == .emailSignup {
          ZStack {
            ProgressBar(percent: 35)
            ProgressNumberView()
            SignUpTitles(title: "Let's make an account!", subtitle: "Enter your email and Password")
            EmailPass()
          }
        } else if signupViewModel.index == .phoneNumber {
          ZStack{
            PhoneNumber().environmentObject(phoneViewModel)
          }
        } else if signupViewModel.index == .phoneVerify {
          VerifyPhoneNumber().environmentObject(phoneViewModel)
        } else if signupViewModel.index == .names {
          ZStack {
            ProgressBar(percent: 70)
            ProgressNumberView()
            SignUpTitles(title: "Names", subtitle: nil)
            Names()
          }
        } else if signupViewModel.index == .bio {
          ZStack{
            ProgressBar(percent: 100)
            ProgressNumberView()
            SignUpTitles(title: "Add a photo and bio", subtitle: "Help your friends to identify you.")
            AvatarBio()
          }
        } else if signupViewModel.index == .loginMethod {
          LoginMethod()
        } else if signupViewModel.index == .loginWithEmail {
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

enum OnboardingScreen: String {
  case signupOrLogin = "Signup Or Login"
  case inviteCode = "Invite Code"
  case emailSignup = "Email Signup"
  case phoneNumber = "Phone Number"
  case phoneVerify = "Phone Verify"
  case names = "Names"
  case bio = "Bio"
  case loginMethod = "Login Method"
  case loginWithEmail = "Login with Email"
}
