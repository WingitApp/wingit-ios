//
//  UserApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import FirebaseAuth

class UserApi {
    func searchUsers(text: String, onSuccess: @escaping(_ users: [User]) -> Void) {
        print(text.lowercased().removingWhitespaces())
        
        Ref.FIRESTORE_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased().removingWhitespaces()).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            print(snap.documents)
            var users = [User]()
            for document in snap.documents {
                let dict = document.data()
                guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                if decoderUser.uid != Auth.auth().currentUser!.uid {
                    users.append(decoderUser)
                }
                
            }
            onSuccess(users)
        }
    }
    
   
    
    func loadUser(userId: String, onSuccess: @escaping(_ user: User) -> Void) {
        Ref.FIRESTORE_DOCUMENT_USERID(userId: userId).getDocument { (snapshot, error) in
          guard let snap = snapshot else {
              print("Error fetching data")
              return
          }
         
              let dict = snap.data()
              guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
              
            onSuccess(decoderUser)
      }
    }
  
    
    func blockUser(userId: String, postOwnerId: String) {
        
        Ref.FIRESTORE_COLLECTION_BLOCKED_USERID(userId: userId).collection("userBlocked").document(postOwnerId).setData(["userBlocking": postOwnerId])
        Ref.FIRESTORE_ROOT.collection("Blocked").document(postOwnerId).collection("userBlockedBy").document(userId).setData(["userBlocked": userId])
        
    }
    
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
        
        Ref.FIRESTORE_DOCUMENT_USERID(userId: userId).updateData([
        
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
        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            var posts = [Post]()
            for document in snap.documents {
                let dict = document.data()
                guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}

                posts.append(decoderPost)
            }
            onSuccess(posts)
        }
    }
    
    func loadGemPosts(userId: String, onSuccess: @escaping(_ gemposts: [gemPost]) -> Void) {
        Ref.FIRESTORE_GEM_POSTS_DOCUMENT_USERID(userId: userId).collection("gemPosts").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            var gemposts = [gemPost]()
            for document in snap.documents {
                let dict = document.data()
                guard let decoderPost = try? gemPost.init(fromDictionary: dict) else {return}

                gemposts.append(decoderPost)
            }
            onSuccess(gemposts)
        }
    }
    
//    func loadDonePosts(userId: String, onSuccess: @escaping(_ doneposts: [DonePost]) -> Void) {
//        Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("donePosts").order(by: "date", descending: true).getDocuments { (snapshot, error) in
//            
//            guard let snap = snapshot else {
//                print("Error fetching data")
//                return
//            }
//            var doneposts = [DonePost]()
//            for document in snap.documents {
//                let dict = document.data()
//                guard let decoderPost = try? DonePost.init(fromDictionary: dict) else {return}
//
//                doneposts.append(decoderPost)
//            }
//            onSuccess(doneposts)
//        }
//    }
}
