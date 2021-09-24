//
//  MainView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import FirebaseAuth
import Foundation
import SwiftUI
import Combine   // << needed for Just publisher below


struct MainView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject var session: SessionStore
  @ObservedObject var model: MainViewModel = MainViewModel()
  @StateObject var profileViewModel = ProfileViewModel()
  @StateObject var activityViewModel = ActivityViewModel()
  @StateObject var homeViewModel = HomeViewModel()
  @StateObject var referViewModel = ReferViewModel()
  
  @State private var home = UUID()
  @State private var referrals = UUID()
  @State private var composePost = UUID()
  @State private var notification = UUID()
  @State private var profile = UUID()
  
  @State private var tapCount = 0
  @State private var selection: Int = 0

  var handler: Binding<Int> { Binding(
        get: { selection},
        set: {
            if $0 == selection {
                tapCount += 1
            }
            Haptic.impact(type: "medium")
            selection = $0
        }
)}
  
  func logout() {
    session.logout()
  }
    
  var body: some View {
    

    TabView(selection: handler) {
        HomeView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: selection == 0 ? "house.fill" : "house")
              Text("Home")
                .font(.caption2)
            }
          })
          .tag(0)
          .id(home)
          .onChange(
            of: tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                home = UUID()
                self.tapCount = 0
              }
          })
        ReferralsView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: selection == 1 ? "paperplane.fill" : "paperplane" )
              Text("Inbox")
                .font(.caption2)
            }
          })
          .tag(1)
          .id(referrals)
          .onChange(
            of: tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                referrals = UUID()
                self.tapCount = 0
              }
          })
        ComposePostView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: "plus.circle.fill")
              Text("Ask")
                .font(.caption2)
            }
          })
          .tag(2)
          .id(composePost)
          .onChange(
            of: tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                composePost = UUID()
                self.tapCount = 0
              }
          })
        NotificationView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: selection == 3 ? "bell.fill" : "bell")
              Text("Notifs")
                .font(.caption2)
            }
            
          })
          .tag(3)
          .id(notification)
          .onChange(
            of: tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                notification = UUID()
                self.tapCount = 0
              }
          })
        ProfileView()
//        ProfileDetail2()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: selection == 4 ? "person.fill" : "person")
              Text("You")
                .font(.caption2)
            }
          })
          .tag(4)
          .id(profile)
          .onChange(
            of: tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                profile = UUID()
                self.tapCount = 0
              }
          })
     }
    .accentColor(.wingitBlue)
    .environmentObject(profileViewModel)
    .environmentObject(activityViewModel)
    .environmentObject(homeViewModel)
    .environmentObject(referViewModel)
    .onAppear{
        self.homeViewModel.loadTimeline()
        self.profileViewModel.loadUserPosts()
        self.activityViewModel.loadActivities()
    }
  }
}
