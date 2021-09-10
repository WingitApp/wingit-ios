//
//  MainView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import FirebaseAuth
import Foundation
import SwiftUI


import FirebaseAuth
import Foundation
import SwiftUI

struct MainView: View {
  @EnvironmentObject var session: SessionStore
  @ObservedObject var model: MainViewModel = MainViewModel()
  @StateObject var profileViewModel = ProfileViewModel()
  @StateObject var activityViewModel = ActivityViewModel()
  @StateObject var homeViewModel = HomeViewModel()

  func logout() {
    session.logout()
  }
    
  var body: some View {
    TabView(selection: $model.selectedIndex) {
        HomeView()
          .tabItem({ Image(systemName: "house.fill") })
          .tag(0)
          .environmentObject(profileViewModel)
          .environmentObject(activityViewModel)
          .environmentObject(homeViewModel)
        ReferralsView()
          .tabItem({ Image(systemName: "suit.heart") })
          .tag(1)
          .environmentObject(profileViewModel)
          .environmentObject(activityViewModel)
          .environmentObject(homeViewModel)
        ComposePostView()
          .tabItem({ Image(systemName: IMAGE_PHOTO) })
          .tag(2)
          .environmentObject(profileViewModel)
          .environmentObject(activityViewModel)
          .environmentObject(homeViewModel)
        NotificationView()
          .tabItem({ Image(systemName: "bell") })
          .tag(3)
          .environmentObject(profileViewModel)
          .environmentObject(activityViewModel)
          .environmentObject(homeViewModel)
        ProfileView()
          .tabItem({ Image(systemName: "person.fill") })
          .tag(4)
          .environmentObject(profileViewModel)
          .environmentObject(activityViewModel)
          .environmentObject(homeViewModel)
     }
    .accentColor(Color(.systemTeal))
    .environmentObject(profileViewModel)
    .environmentObject(activityViewModel)
    .environmentObject(homeViewModel)
    .onAppear{
        self.profileViewModel.loadUserPosts()
        self.activityViewModel.loadActivities()
    }
  }
}
