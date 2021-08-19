//
//  MainView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var model: MainViewModel = MainViewModel()

    func logout() {
        session.logout()
    }
    
    
    var body: some View {
        TabView(selection: $model.selectedIndex) {
            NavigationTab(
                tag: 0,
                icon: "house.fill",
                view: AnyView(HomeView())
            )
            NavigationTab(
                tag: 1,
                icon: "magnifyingglass",
                view: AnyView(SearchView())
            )
            NavigationTab(
                tag: 2,
                icon: IMAGE_PHOTO,
                view: AnyView(CameraView())
            )
            NavigationTab(
                tag: 3,
                icon: "bell",
                view: AnyView(NotificationView())
            )
            NavigationTab(
                tag: 4,
                icon: "person.fill",
                view: AnyView(ProfileView())
            )
         }.accentColor(Color(.systemTeal))
    }

}
