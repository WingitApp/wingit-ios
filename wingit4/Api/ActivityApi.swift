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
    
    func loadActivities(
      onEmpty: @escaping () -> Void,
      onSuccess: @escaping(_ activityArray: [Activity]) -> Void,
      newActivity: @escaping(Activity) -> Void,
      deleteActivity: @escaping(Activity) -> Void,
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
                    var activityArray = [Activity]()
                      let dict = documentChange.document.data()
                      guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
                      newActivity(decoderActivity)
                      activityArray.append(decoderActivity)
                      onSuccess(activityArray)
                  case .modified:
                    break
                  case .removed:
                      let dict = documentChange.document.data()
                       guard let decoderActivity = try? Activity.init(fromDictionary: dict) else {return}
                       deleteActivity(decoderActivity)
                  }
            }
            
        })
        
        listener(listenerFirestore)
        
    }
}