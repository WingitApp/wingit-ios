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
//    @AppStorage("log_Status") var status = false
    @State var hasSeenOnboarding: Bool = false
    
  
  /*
   if log status is true then Names.
   if Names is true then upload avatar & bio.
   if they skip it then change those status to true --> Main View.
   */
  
    func listen() {
      let localStorage = UserDefaults.standard
      if let hasSeenOnboarding = localStorage.string(forKey: localStorageKeys.onboarding) {
        if hasSeenOnboarding == "true" {
          self.hasSeenOnboarding = true
        }
      }
      session.listenAuthenticationState()
    }
  
  func showLoginSignUpScreen() {
    let localStorage = UserDefaults.standard
    localStorage.set("true", forKey: localStorageKeys.onboarding)
    withAnimation {
      self.hasSeenOnboarding = true
    }
  }
    
  var body: some View {
    Group {
      if session.isLoggedIn {
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
