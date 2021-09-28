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
      onSuccess: @escaping(_ activityArray: [UserActivity]) -> Void,
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
                    var activityArray = [UserActivity]()
                      guard let decodedActivity = try? documentChange.document.data(as: UserActivity.self) else { return }
                      newActivity(decodedActivity)
                      activityArray.append(decodedActivity)
                      onSuccess(activityArray)
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
}
