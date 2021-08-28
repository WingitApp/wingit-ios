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
  
  func logout() {
    session.logout()
  }
    
  var body: some View {
    TabView(selection: $model.selectedIndex) {
        NavigationTab(
            tag: 0,
            icon: "house.fill",
            screen: AnyView(HomeView())
        )
        NavigationTab(
            tag: 1,
            icon: IMAGE_PHOTO,
            screen: AnyView(CameraView())
        )
        NavigationTab(
            tag: 2,
            icon: "bell",
            screen: AnyView(NotificationView())
        )
        NavigationTab(
            tag: 3,
            icon: "person.fill",
            screen: AnyView(ProfileView())
        )
     }
    .environmentObject(profileViewModel)
    .environmentObject(activityViewModel)
    .onAppear{
        self.profileViewModel.loadUserPosts()
        self.activityViewModel.loadActivities()
    }
    .accentColor(Color(.systemTeal))
  }
}
