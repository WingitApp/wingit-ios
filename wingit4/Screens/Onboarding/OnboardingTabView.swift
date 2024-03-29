////
////  OnboardingTabView.swift
////  wingit4
////
////  Created by YaeRim Amy Chun on 9/9/21.
////
//
//import SwiftUI
//
//struct OnboardingTabView: View {
//    @State private var tabSelection = 0
//    @StateObject var signupViewModel = SignupViewModel()
//
//    var body: some View {
//        TabView (selection: $tabSelection) {
//            // DragGesture prevents the user from swiping past the SignupForm
//            OnboardingSignupForm(tabSelection: $tabSelection).gesture(DragGesture()).tag(0)
//            OnboardingProfilePhoto(selectedTab: $tabSelection).tag(1)
//            OnboardingContacts().tag(2)
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .environmentObject(signupViewModel)
//        .navigationBarHidden(true)
//    }
//}
