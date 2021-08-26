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
  @StateObject var profileViewModel = ProfileViewModel()
  @ObservedObject var model: MainViewModel = MainViewModel()
  
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
//            NavigationTab(
//                tag: 1,
//                icon: "magnifyingglass",
//                screen: AnyView(SearchView())
//            )
        NavigationTab(
            tag: 2,
            icon: IMAGE_PHOTO,
            screen: AnyView(CameraView())
        )
        NavigationTab(
            tag: 3,
            icon: "bell",
            screen: AnyView(NotificationView())
        )
        NavigationTab(
            tag: 4,
            icon: "person.fill",
            screen: AnyView(ProfileView())
        )
     }
    .environmentObject(profileViewModel)
    .onAppear{
      self.profileViewModel.loadUserPosts(userId: Auth.auth().currentUser!.uid)
    }
    .accentColor(Color(.systemTeal))
  }
}
