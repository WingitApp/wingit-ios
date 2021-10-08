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
  @StateObject var mainViewModel = MainViewModel()
  @StateObject var updatePhotoVM = UpdatePhotoVM()

//  @StateObject var profileViewModel = ProfileViewModel()
  @StateObject var notificationViewModel = NotificationViewModel()
  @StateObject var homeViewModel = HomeViewModel()
  @StateObject var referViewModel = ReferViewModel()

  
  @State private var home = UUID()
  @State private var referrals = UUID()
  @State private var composePost = UUID()
  @State private var notification = UUID()
  @State private var profile = UUID()
  
  
  
  func logout() {
    session.logout()
  }
    
  var body: some View {
    

    TabView(selection: mainViewModel.tabHandler) {
        HomeView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: mainViewModel.selection == 0 ? "house.fill" : "house")
                .imageScale(.small)
              Text("Home")
                .font(.caption2)
            }
          })
          .tag(0)
          .id(home)
          .onChange(
            of: mainViewModel.tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                home = UUID()
                mainViewModel.tapCount = 0
              }
          })
          .transition(.slide) // 3
        ReferralsView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: mainViewModel.selection == 1 ? "paperplane.fill" : "paperplane" )
                .imageScale(.small)
              Text("Inbox")
                .font(.caption2)
            }
          })
          .tag(1)
          .id(referrals)
          .onChange(
            of: mainViewModel.tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                referrals = UUID()
                self.mainViewModel.tapCount = 0
              }
          })
        ComposePostView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: "plus.circle.fill")
                .imageScale(.large)
              Text("Ask")
                .font(.caption2)
            }
          })
          .tag(2)
          .id(composePost)
          .onChange(
            of: mainViewModel.tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                composePost = UUID()
                self.mainViewModel.tapCount = 0
              }
          })
        NotificationView()
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: mainViewModel.selection == 3 ? "bell.fill" : "bell")
                .imageScale(.small)
              Text("Notifs")
                .font(.caption2)
            }
            
          })
          .tag(3)
          .id(notification)
          .onChange(
            of: mainViewModel.tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                notification = UUID()
                self.mainViewModel.tapCount = 0
              }
          })
        ProfileView(
          profileTab: true
        )
          .tabItem({
            VStack(alignment: .center ){
              Image(systemName: mainViewModel.selection == 4 ? "person.fill" : "person")
                .imageScale(.small)
              Text("You")
                .font(.caption2)
            }
          })
          .tag(4)
          .id(profile)
          .onChange(
            of: mainViewModel.tapCount,
            perform: { tapCount in
              if tapCount == 1 {
                profile = UUID()
                self.mainViewModel.tapCount = 0
              }
          })
      
     }

    .accentColor(.wingitBlue)
    .environmentObject(notificationViewModel)
    .environmentObject(homeViewModel)
    .environmentObject(referViewModel)
    .environmentObject(mainViewModel)
    .environmentObject(updatePhotoVM)
    .onAppear{
        self.homeViewModel.loadTimeline()
        self.notificationViewModel.loadNotifications()
        self.session.loadUserProfile()
        self.updatePhotoVM.loadCurrentImage(userAvatar: session.currentUser?.profileImageUrl)
    }
  }
}
