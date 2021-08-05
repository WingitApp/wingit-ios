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
            HomeView().tabItem({
                    Image(systemName: "house.fill")
                }).tag(0)
            SearchView().tabItem({
                    Image(systemName: "magnifyingglass")
                }).tag(1)
                CameraView().tabItem({
                    Image(systemName: IMAGE_PHOTO)
                }).tag(2)
                NotificationView().tabItem({
                    Image(systemName: "bell")
                }).tag(3)
            ProfileView().tabItem({
                    Image(systemName: "person.fill")
                }).tag(4)
         }.accentColor(Color(.systemTeal))
    }

//    var body: some View {
//         TabView {
//            HomeView().tabItem({
//                        Image(systemName: "house.fill")
//                }).tag(0)
//            SearchView().tabItem({
//                    Image(systemName: "magnifyingglass")
//                }).tag(1)
//                CameraView().tabItem({
//                    Image(systemName: IMAGE_PHOTO)
//                }).tag(2)
//                NotificationView().tabItem({
//                    Image(systemName: "bell")
//                }).tag(3)
//            ProfileView().tabItem({
//                    Image(systemName: "person.fill")
//                }).tag(4)
//         }.accentColor(Color(.systemTeal))
//    }
}
