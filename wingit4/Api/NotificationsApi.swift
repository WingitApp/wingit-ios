//
//  NotificationsApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/21/21.
//

//import Foundation
//
//class NotificationsApi {
//
//func loadNotifications() {
//
//
//    let ref = Database.database().reference()
//    ref.child("users").child(self.loggedInUser.id).child("notifications").observeSingleEvent(of: .value, with: {
//        snapshot in
//        for snap in snapshot.children.allObjects as! [DataSnapshot] {
//            guard let dict = snap.value as? [String : AnyObject] else { return }
//            self.notifications.append(handleNotificationDict(notificationID: snap.key, dict))
//        }
//    })
//}
//
//}
