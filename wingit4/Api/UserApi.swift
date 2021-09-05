//
//  UserApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import FirebaseFirestoreSwift
import Foundation
import Firebase
import FirebaseAuth

class UserApi {
    func searchUsers(text: String, onSuccess: @escaping(_ users: [User]) -> Void) {
       // print(text.lowercased().removingWhitespaces())
        
        Ref.FS_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased().removingWhitespaces()).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
             //   print("Error fetching data")
                return
            }
          //  print(snap.documents)
            var users = [User]()
            for document in snap.documents {
                let dict = document.data()
                guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                if decodedUser.id != Auth.auth().currentUser!.uid {
                    users.append(decodedUser)
                }
            }
            onSuccess(users)
        }
    }
    
    func loadUser(userId: String, onSuccess: @escaping(_ user: User) -> Void) {
        Ref.FS_DOC_USERID(userId: userId).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let snapshot = snapshot {
                let result = Result { try snapshot.data(as: User.self) }
                    switch result {
                        case .success(let user):
                          if let user = user {
                            onSuccess(user)
                          } else {
                            print("User document doesn't exist.")
                          }
                        case .failure(let error):
                          // A User could not be initialized from the DocumentSnapshot.
                            printDecodingError(error: error)
                        }
            }
        }
    }
  
    func blockUser(userId: String, postOwnerId: String) {
        
        Ref.FS_DOC_BLOCKED_USERID(userId: userId).collection("userBlocked").document(postOwnerId).setData(["userBlocking": postOwnerId])
        Ref.FS_ROOT.collection("Blocked").document(postOwnerId).collection("userBlockedBy").document(userId).setData(["userBlocked": userId])
        
    }
    
    func updateImage(imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.updateAvatar(userId: userId, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId, onSuccess: onSuccess, onError: onError)
    }
    
//    func updateImage(field : String){
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        alertView(msg: "Update \(field)") { (txt) in
//            if txt != ""{
//                Ref.FIRESTORE_DOCUMENT_USERID(userId: userId).updateData([
//
//                    "profileImageURL": txt
//
//                ]) { (err) in
//
//                    if err != nil{return}
//
//                }
////                let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
////                let metadata = StorageMetadata()
////                metadata.contentType = "image/jpg"
////
//            }
//        }
//
//    }
    

    
    func updateDetails(field : String){
        
        alertView(msg: "Update \(field)") { (txt) in
            
            if txt != ""{
                
                self.updateBio(id: field == "Name" ? "username" : "bio", value: txt)
            }
        }
    }
    
    func updateBio(id: String,value: String){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Ref.FS_DOC_USERID(userId: userId).updateData([
        
            id: value,
            
        ]) { (err) in
            
            if err != nil{return}
            
        }
    }
    
//    func getUpdate(userId: String, completion: @escaping (User) -> ()) {
//        Ref.FIRESTORE_DOCUMENT_USERID(userId: userId).getDocument { (snapshot, error) in
//
//            if let dict = snapshot?.data() {
//
//                guard (try? User.init(fromDictionary: dict)) != nil else {return}
//            }
//
//        }
//    }
//

    
    func loadPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            
            if let error = error {
              print(error)
            } else if let snapshot = snapshot {
              let posts: [Post] = snapshot.documents.compactMap {
                return try? $0.data(as: Post.self)
              }
                onSuccess(posts)
            }
        }
    }
        
    func loadDonePosts(userId: String, onSuccess: @escaping(_ doneposts: [DonePost]) -> Void) {
        Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("donePosts").order(by: "donedate", descending: true).getDocuments { (snapshot, error) in
            
            guard let snap = snapshot else {
             //   print("Error fetching data")
                return
            }
            var doneposts = [DonePost]()
            for document in snap.documents {
                let dict = document.data()
                guard let decodedPost = try? DonePost.init(fromDictionary: dict) else {return}

                doneposts.append(decodedPost)
            }
            onSuccess(doneposts)
        }
    }
}
