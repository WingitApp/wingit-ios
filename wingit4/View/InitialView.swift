//
//  InitialView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import SwiftUI

struct InitialView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView()
            } else {
                SigninView()
            }

        }.onAppear(perform: listen)
    }
}
