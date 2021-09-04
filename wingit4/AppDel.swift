//
//  AppDel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import Foundation
import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
  //  print("Colors application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    return true
  }
}


@main
struct WingitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // Define deepLink
  //  @State var deepLink: DeepLinkHandler.DeepLink?
    let sessionStore = SessionStore()
    
  var body: some Scene {
    WindowGroup {
      InitialView().environmentObject(sessionStore)

    }
  }

}
