//
//  MainView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//
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
        CameraView()
          .tabItem({ Image(systemName: IMAGE_PHOTO) })
          .tag(1)
        NotificationView()
          .tabItem({ Image(systemName: "bell") })
          .tag(2)
        ProfileView()
          .tabItem({ Image(systemName: "person.fill") })
          .tag(3)
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
