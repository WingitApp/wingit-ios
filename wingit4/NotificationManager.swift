//
//  NotificationManager.swift
//  wingit4
//
//  Created by Amy Chun on 10/1/21.
//

//enum MyViews {
//    case viewA
//    case viewB
//    case viewC
//}
//
//class NotificationManager: NSObject, ObservableObject {
//    @Published var currentViewId: MyViews?
//
//    @ViewBuilder
//    func currentView(for id: MyViews) -> some View {
//        switch id {
//        case .viewA:
//            ViewA()
//        case .viewB:
//            ViewB()
//        case .viewC:
//            ViewC()
//        }
//    }
//}
//
//extension NotificationManager: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        //App is in foreground
//        //do whatever you want here, for example:
//        currentViewId = .viewB
//        completionHandler([.sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        //App is in background, user has tapped on the notification
//        //do whatever you want here, for example:
//        currentViewId = .viewB
//        completionHandler()
//    }
//}
//
