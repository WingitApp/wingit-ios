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
  
  @State private var selection: Int = 0

  func logout() {
    session.logout()
  }
    
  var body: some View {
    TabView(selection: $selection) {
        HomeView()
          .tabItem({ Image(systemName: "house") })
          .tag(0)
        ReferralsView()
          .tabItem({ Image(systemName: "suit.heart") })
          .tag(1)
        ComposePostView()
          .tabItem({
            Image(systemName: "plus.circle.fill")
              .foregroundColor(Color(.systemTeal))
          })
          .tag(2)
        NotificationView()
          .tabItem({ Image(systemName: "bell") })
          .tag(3)

        ProfileView()
//        ProfileDetail2()
          .tabItem({ Image(systemName: "person") })
          .tag(4)
     }
    .accentColor(.wingitBlue)
    .environmentObject(profileViewModel)
    .environmentObject(activityViewModel)
    .environmentObject(homeViewModel)
    .environmentObject(referViewModel)

    .onAppear{
        self.profileViewModel.loadUserPosts()
        self.activityViewModel.loadActivities()
        self.homeViewModel.loadTimeline()
    }
  }
}
