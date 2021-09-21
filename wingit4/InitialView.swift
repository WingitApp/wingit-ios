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
//    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @AppStorage("currentPage") var currentPage = 1
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        Group {
            if session.isLoggedIn && currentPage > totalPages {
                MainView()
            } else if !session.isLoggedIn {
                SigninView()
            }
        }
        .onAppear(perform: listen)
        .preferredColorScheme(.light)
        //  .environment(\.colorScheme, .dark)
//        .fullScreenCover(
//            isPresented: $shouldShowOnboarding,
//            content: { IntroView().preferredColorScheme(.light)}
//        )
    }
}
