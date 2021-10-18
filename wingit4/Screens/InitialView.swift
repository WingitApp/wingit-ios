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
    @AppStorage("log_Status") var status = false
  
  /*
   if log status is true then Names.
   if Names is true then upload avatar & bio.
   if they skip it then change those status to true --> Main View.
   */
  
    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView()
            } 
            else {
              OnboardingView()
//                FirstView()
               // OnboardingV2()
            }
        }
        .onAppear(perform: listen)
        .preferredColorScheme(.light)
       
      //  .environment(\.colorScheme, .dark)
    }
}
