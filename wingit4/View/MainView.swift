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

    func logout() {
        session.logout()
    }

    var body: some View {
         TabView {
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

        //        Group {
        //            Text((session.userSession == nil) ? "Loading..." : session.userSession!.email)
        //            Button(action: logout) {
        //               Text("Log out")
        //            }
        //        }
    }
}

//let tabBarImageNames = ["house.fill", "magnifyingglass", "plus.app.fill", "bell", "person.fill"]

//struct MainView: View {
//    @EnvironmentObject var session: SessionStore
//
//    func logout() {
//        session.logout()
//    }
//    @State var selectedTabIndex = 0
//
//    private let tabBarImageNames = ["house.fill", "magnifyingglass", "plus.app.fill", "bell", "person.fill"]
//
//    init() {
//        UINavigationBar.appearance().barTintColor = .white
//    }
//
//    @State var imageData: Data?
//    @State var shouldShowImagePicker = false
//
//    var body: some View {
//
//        GeometryReader { proxy in
//            ZStack {
//
//                Spacer()
//
//
//                VStack(spacing: 0) {
//
//                    switch selectedTabIndex {
//                    case 0:
//                       HomeView()
//                    case 1:
//                       SearchView()
//                    case 2:
//                       CameraView()
//                    case 3:
//                        NotificationView()
//                    case 4:
//                        ProfileView()
//                    default:
//                        NavigationView {
//                            VStack {
//                                Text("\(tabBarImageNames[selectedTabIndex])")
//                                Spacer()
//                            }
//                            .navigationTitle("\(tabBarImageNames[selectedTabIndex])")
//                        }
//                    }
//
//                    Divider()
//                    HStack {
//                        ForEach(0..<5, id: \.self) { num in
//                            HStack {
//                                Button(action: {
//                                    self.selectedTabIndex = num
//                                }, label: {
//                                    Spacer()
//                                    if num == 2 {
//                                        Image(systemName: tabBarImageNames[num])
//                                            .foregroundColor(Color(.systemTeal))
//                                            .font(.system(size: 44, weight: .semibold))
//                                    } else {
//                                        Image(systemName: tabBarImageNames[num])
//                                            .foregroundColor(selectedTabIndex == num ? Color(.systemTeal) : .init(white: 0.7))
//                                    }
//
//                                    Spacer()
//                                })
//                            }.font(.system(size: 24, weight: .semibold))
//                        }
//                    }
//                    .padding(.top, 12)
//                    .padding(.bottom, 12)
//                    .padding(.bottom, proxy.safeAreaInsets.bottom)
//                }.edgesIgnoringSafeArea(.bottom)
//            }
//        }
//
//    }
//}
