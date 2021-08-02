//
//  AppDelegate.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Amplitude
import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        // Enable sending automatic session events
        Amplitude.instance().trackingSessionEvents = true
        // Initialize SDK
        Amplitude.instance().initializeApiKey("c09ca9702b55aee4ce26f173e29d2444")
        Amplitude.instance().setUserId(Auth.auth().currentUser?.uid)
        logToAmplitude(event: .appStart)
        return true
    }

    // MARK: UISceneSession Lifecycle
 
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
