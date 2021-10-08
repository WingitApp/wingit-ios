//
//  AppDel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import Amplitude
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
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.list, .banner, .sound]])
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
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
    }
  }
    

}
