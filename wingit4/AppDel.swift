//
//  AppDel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import Amplitude
import Combine
import Foundation
import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications
import URLImage
import URLImageStore

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate {
  private var operationQueue = OperationQueue()

  var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()
    
    // Amplitude analytics
    if let amplitudeKey = Bundle.main.object(forInfoDictionaryKey: "AmplitudeKey") as? String {
        let amplitude = Amplitude.instance()
        amplitude.trackingSessionEvents = true
        amplitude.initializeApiKey(amplitudeKey)
        if let accountId = Auth.auth().currentUser?.uid {
            amplitude.setUserId(accountId)
        }
        logToAmplitude(event: .appStart)
    }
    
    Messaging.messaging().delegate = self
    UNUserNotificationCenter.current().delegate = self
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.alert, .sound, .badge]
    ) { success, _ in
      guard success else { return }
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


    completionHandler(UIBackgroundFetchResult.newData)
  }

  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    messaging.token {token, _ in
      guard let token = token else { return }
      
      let hasDevice = UserDefaults.standard.string(forKey: DeviceUserDefaultKeys.id.rawValue) != nil
      
      if (hasDevice) {
          Api.Device.updateDeviceInFirestore(token: token)
      } else {
          Api.Device.createDevice(token: token)
      }
    }
  }
  
  
  func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken;
  }
  
  func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("FAILED TO REGISTER FOR TOKEN")

  }

   
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  func isEqual<T: Equatable>(type: T.Type, a: Any?, b: Any?) -> Bool {
      guard let a = a as? T, let b = b as? T else { return false }

      return a == b
  }
  
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo = notification.request.content.userInfo
    print(userInfo)
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.list, .banner, .sound]])
  }
  
  func routePushToCorrespondingScreen(pushData: [AnyHashable: Any]) {
    ViewRouter.shared.activityId = pushData["activityId"] as? String
    if isEqual(type: String.self,
               a: pushData["type"],
               b: Notification.NotificationType.comment.rawValue) {
                ViewRouter.shared.tabSelection = .notifications
                ViewRouter.shared.currentScreen = .askDetail
                ViewRouter.shared.postId = pushData["postId"] as? String
    } else if isEqual(type: String.self,
              a: pushData["type"],
              b: Notification.NotificationType.connectRequest.rawValue) {
                ViewRouter.shared.tabSelection = .notifications
                ViewRouter.shared.currentScreen = .userProfile
                ViewRouter.shared.userId = pushData["userId"] as? String
    } else if isEqual(type: String.self,
              a: pushData["type"],
              b: Notification.NotificationType.connectRequestAccepted.rawValue) {
                ViewRouter.shared.tabSelection = .notifications
                ViewRouter.shared.currentScreen = .userProfile
                ViewRouter.shared.userId = pushData["userId"] as? String
    } else if isEqual(type: String.self,
              a: pushData["type"],
              b: Notification.NotificationType.referred.rawValue) {
                ViewRouter.shared.tabSelection = .referrals
    }
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    let userInfo = response.notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    routePushToCorrespondingScreen(pushData: userInfo)

    completionHandler()
  }

}

@main
struct WingitApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @State var deepLink: ViewRouter.DeepLink?
  
  let sessionStore = SessionStore()
  
  var body: some Scene {
    let urlImageService = URLImageService(
      fileStore: URLImageFileStore(),
      inMemoryStore: URLImageInMemoryStore()
    )
    
    WindowGroup {
      InitialView()
        .environment(\.urlImageService, urlImageService)
        .environmentObject(sessionStore)
        .onOpenURL { url in
          print("Incoming URL parameter is: \(url)")
          let linkHandled = DynamicLinks.dynamicLinks()
            .handleUniversalLink(url) { dynamicLink, error in
              guard error == nil else {
                fatalError("Error handling the incoming dynamic link.")
              }
              if let dynamicLink = dynamicLink {
                // Handle Dynamic Link
                self.handleDynamicLink(dynamicLink)
              }
            }
          if linkHandled {
            print("Link Handled")
          } else {
            print("No Link Handled")
          }
        }
        // Add environment modifier
        .environment(\.deepLink, deepLink)
    }
  }
  
  // MARK: - Functions
  // Handle incoming dynamic link
  func handleDynamicLink(_ dynamicLink: DynamicLink) {
    guard let url = dynamicLink.url else { return }

    print("Your incoming link parameter is \(url.absoluteString)")
    // 1
    guard
      dynamicLink.matchType == .unique ||
      dynamicLink.matchType == .default
    else {
      return
    }
    guard let deepLink = ViewRouter.shared.parseComponents(from: url) else {
      return
    }
    self.deepLink = deepLink
    print("Deep link: \(deepLink)")
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.deepLink = nil
    }
  }
}
