//
//  NotificationsApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//
import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class NotificationsApi {
    
    func loadNotifications(
      onEmpty: @escaping () -> Void,
      newNotification: @escaping(Notification) -> Void,
      deleteNotification: @escaping(Notification) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        
        let listenerFirestore =  Ref.FS_COLLECTION_ACTIVITY.document(userId).collection("feedItems").order(by: "date", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else { return }
          
            if snapshot.documentChanges.isEmpty {
              onEmpty()
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                      var decodedNotification = try? documentChange.document.data(as: Notification.self)
                      if (decodedNotification != nil && decodedNotification?.type == "comment") {
                          Api.Post.loadPost(postId: decodedNotification?.postId) { (post) in
                              decodedNotification?.post = post
                              guard let notification = decodedNotification else { return }
                              newNotification(notification)
                          }
                      } else {
                          guard let notification = decodedNotification else { return }
                          newNotification(notification)
                      }
                  case .modified:
                      break
                  case .removed:
                      guard let decodedNotification = try? documentChange.document.data(as: Notification.self) else { return }
                    deleteNotification(decodedNotification)
                  }
            }
            
        })
        
        listener(listenerFirestore)
        
    }
}
