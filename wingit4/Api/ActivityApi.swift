//
//  ActivityApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/11/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ActivityApi {
    
    func loadActivities(onSuccess: @escaping(_ activityArray: [ActivityEvent]) -> Void, newActivity: @escaping(ActivityEvent) -> Void, deleteActivity: @escaping(ActivityEvent) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FS_COLLECTION_ACTIVITY_EVENTS_FOR_USER(userId: userId).order(by: "createdAt", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                   return
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                    if let activity = try? documentChange.document.data(as: ActivityEvent.self) {
                        var activityArray = [ActivityEvent]()
                        newActivity(activity)
                        activityArray.append(activity)
                        onSuccess(activityArray)
                    }
                  case .modified:
                    break
                  case .removed:
                    if let activity = try? documentChange.document.data(as: ActivityEvent.self) {
                       deleteActivity(activity)
                    }
                  }
            }
            
        })
        
        listener(listenerFirestore)
        
    }
}
