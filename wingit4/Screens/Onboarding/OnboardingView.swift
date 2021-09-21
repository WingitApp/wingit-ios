//
//  OnboardingView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI

struct OnboardingView: View {
    @State private var tabSelection = 0
    @StateObject var signupViewModel = SignupViewModel()

    var body: some View {
        TabView (selection: $tabSelection) {
            OnboardingSignupForm(tabSelection: $tabSelection).tag(0)
            OnboardingProfilePhoto(selectedTab: $tabSelection).tag(1)
            OnboardingContacts().tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .environmentObject(signupViewModel)
    }
}
