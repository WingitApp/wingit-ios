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
//        .onOpenURL { url in
//          print("Incoming URL parameter is: \(url)")
//          // 2
//          let linkHandled = DynamicLinks.dynamicLinks()
//            .handleUniversalLink(url) { dynamicLink, error in
//            guard error == nil else {
//              fatalError("Error handling the incoming dynamic link.")
//            }
//            // 3
//            if let dynamicLink = dynamicLink {
//              // Handle Dynamic Link
//              self.handleDynamicLink(dynamicLink)
//            }
//          }
//          // 4
//          if linkHandled {
//            print("Link Handled")
//          } else {
//            print("No Link Handled")
//          }
//        }
//        .environment(\.deepLink, deepLink)
    }
  }
    
//    func handleDynamicLink(_ dynamicLink: DynamicLink) {
//        guard let url = dynamicLink.url else { return }
//
//        print("Your incoming link parameter is \(url.absoluteString)")
//        // 1
//        guard
//          dynamicLink.matchType == .unique ||
//          dynamicLink.matchType == .default
//        else {
//          return
//        }
//        // 2
//        let deepLinkHandler = DeepLinkHandler()
//        guard let deepLink = deepLinkHandler.parseComponents(from: url) else {
//          return
//        }
//        self.deepLink = deepLink
//        print("Deep link: \(deepLink)")
//        // 3
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//          self.deepLink = nil
//        }
//    }

}
