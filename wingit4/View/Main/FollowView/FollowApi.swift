//
//  FollowerApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/14/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase


class FollowApi {
    
    func getFollowers(userId: String, onSuccess: @escaping(_ users: [User]) -> Void){
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments{ (snapshot, error) in
            guard let snap = snapshot else {
           //     print("Error fetching data")
                return
            }
            var users = [User]()
            for follower in snap.documents {
          
                let followerId = follower.documentID
                Ref.FIRESTORE_DOCUMENT_USERID(userId: followerId).getDocument{ (document, error) in
                    if let dict = document?.data() {
                        guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                        users.append(decoderUser)
                        }
                    onSuccess(users)
                    }
            }
        }
    }
    
    func getFollowing(userId: String, onSuccess: @escaping(_ users: [User]) -> Void){
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId).getDocuments{ (snapshot, error) in
            guard let snap = snapshot else {
              //  print("Error fetching data")
                return
            }
            var users = [User]()
            for follower in snap.documents {
          
                let followerId = follower.documentID
                Ref.FIRESTORE_DOCUMENT_USERID(userId: followerId).getDocument{ (document, error) in
                    if let dict = document?.data() {
                        guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                        users.append(decoderUser)
                        }
                    onSuccess(users)
                    }
            }
        }
    }

    
}
