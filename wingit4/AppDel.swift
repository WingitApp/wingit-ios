//
//  AppDel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
  var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
  //  print("Colors application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
      guard success else {
        return
      }
      print("Success in APNS registry")
    }
    
    application.registerForRemoteNotifications()
    
    return true
  }
  
  
  /// Handles silent push notifications - https://firebase.google.com/docs/cloud-messaging/ios/receive#handle_silent_push_notifications

  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                     -> Void) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    completionHandler(UIBackgroundFetchResult.newData)
  }

  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    messaging.token {token, _ in
      guard let token = token else {
        return
      }
      
      print("TOKEN: \(token)")
    }
  }
  
  func application(_ application: UIApplication,
  didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken;
  }
   
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.list, .banner, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
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
