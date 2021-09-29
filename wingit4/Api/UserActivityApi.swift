//
//  UserActivity.swift
//  wingit4
//
//  Created by Daniel Yee on 9/28/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class UserActivityApi {
    
    func loadActivity(
      onEmpty: @escaping () -> Void,
      newActivity: @escaping(UserActivity) -> Void,
      deleteActivity: @escaping(UserActivity) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FS_COLLECTION_USER_ACTIVITY.document(userId).collection("activity").order(by: "date", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else { return }
          
            if snapshot.documentChanges.isEmpty {
              onEmpty()
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                      guard let decodedActivity = try? documentChange.document.data(as: UserActivity.self) else { return }
                      newActivity(decodedActivity)
                  case .modified:
                    break
                  case .removed:
                      guard let decodedActivity = try? documentChange.document.data(as: UserActivity.self) else { return }
                       deleteActivity(decodedActivity)
                  }
            }
            
        })
        
        listener(listenerFirestore)
        
    }
    
    func logActivity(activity: UserActivity) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        try? Ref.FS_COLLECTION_ACTIVITY_FOR_USER(userId: currentUserId).document().setData(from: activity)
    }
}
