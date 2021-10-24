//
//  InitialView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI
import Firebase

struct InitialView: View {
  @EnvironmentObject var session: SessionStore
  @State var hasSeenOnboarding: Bool = false
  @State var onboardingInProgress: Bool = false
  
  /*
   if log status is true then Names.
   if Names is true then upload avatar & bio.
   if they skip it then change those status to true --> Main View.
   */
  
    func listen() {
      let localStorage = UserDefaults.standard
      if let hasSeenOnboarding = localStorage.string(forKey: LocalStorageKeys.onboarding) {
        if hasSeenOnboarding == "true" {
          self.hasSeenOnboarding = true
        }
      }
      self.onboardingInProgress = localStorage.bool(forKey: LocalStorageKeys.onboardingInProgress)
      session.listenAuthenticationState()
    }
  
  func showLoginSignUpScreen() {
    let localStorage = UserDefaults.standard
    localStorage.set("true", forKey: LocalStorageKeys.onboarding)
    withAnimation {
      self.hasSeenOnboarding = true
    }
  }
    
  var body: some View {
    Group {
      if session.isLoggedIn && !onboardingInProgress {
        MainView()
      }
      else {
        if hasSeenOnboarding {
          OnboardingView()
        } else {
          OnboardingCarousel(
            onEnd: showLoginSignUpScreen
          )
        }
      }
    }
    .onAppear(perform: listen)
    .preferredColorScheme(.light)
    
    //  .environment(\.colorScheme, .dark)
  }
}
