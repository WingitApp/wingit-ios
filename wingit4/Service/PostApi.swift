//
//  PostApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class PostApi {
    func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document().documentID
        let firestorePostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document(postId)
        let post = Post.init(caption: caption, likes: [:], location: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: "", date: Date().timeIntervalSince1970, likeCount: 0)
        guard let dict = try? post.toDictionary() else {return}
        
        firestorePostRef.setData(dict) { (error) in
            if error != nil {
              onError(error!.localizedDescription)
              return
            }
            Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelinePosts").document(postId).setData(dict)
            Ref.FIRESTORE_COLLECTION_ALL_ASKS.document(postId).setData(dict)
            onSuccess()
        }
       
    }
    
    func uploadImage(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document().documentID
        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
    
//    func uploadDone(caption: String, imageData: Data, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//
//        let firestorePostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("donePosts").document(postId)
//        let donepost = DonePost.init(caption: caption, doneMediaUrl: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString)
//
//        guard let dict = try? donepost.toDictionary() else {return}
//
//        firestorePostRef.setData(dict) { (error) in
//            if error != nil {
//              onError(error!.localizedDescription)
//              return
//            }
//            Ref.FIRESTORE_COLLECTION_ALL_DONE.document(postId).setData(dict)
//            onSuccess()
//        }
//    }
    
//    func uploadDoneImage(caption: String, imageData: Data, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//        StorageService.savePostDonePhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
//    }
   
        
    func deletePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyPostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document(postId)
      //  let storagePostRef = Ref.STORAGE_POST_ID
        firestoreMyPostRef.delete { (err) in
            if err != nil{
               print(err!.localizedDescription)
                return
            }
            let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
            storagePostRef.delete()
            Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelinePosts").document(postId).delete()
            Ref.FIRESTORE_COLLECTION_ALL_ASKS.document(postId).delete()
        }
    }
//    func deleteDonePost(userId: String, postId: String) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            return
//        }
//        let firestoreMyPostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("donePosts").document(postId)
//      //  let storagePostRef = Ref.STORAGE_POST_ID
//        firestoreMyPostRef.delete { (err) in
//            if err != nil{
//               print(err!.localizedDescription)
//                return
//            }
//            let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
//            storagePostRef.delete()
//        }
//    }
    
    func hidePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyTimeline = Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelinePosts").document(postId)
        
        firestoreMyTimeline.delete() { (err) in
            if err != nil{
               print(err!.localizedDescription)
                return
            }
        }
    }

//    func loadDonePost(postId: String, onSuccess: @escaping(_ donepost: DonePost) -> Void) {
//        Ref.FIRESTORE_COLLECTION_ALL_DONE.document(postId).getDocument { (snapshot, error) in
//          guard let snap = snapshot else {
//              print("Error fetching data")
//              return
//          }
//
//              let dict = snap.data()
//              guard let decoderdonePost = try? DonePost.init(fromDictionary: dict) else {return}
//
//            onSuccess(decoderdonePost)
//      }
//    }

    func loadPost(postId: String, onSuccess: @escaping(_ post: Post) -> Void) {
        Ref.FIRESTORE_COLLECTION_ALL_ASKS.document(postId).getDocument { (snapshot, error) in
          guard let snap = snapshot else {
              print("Error fetching data")
              return
          }
         
              let dict = snap.data()
              guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
              
            onSuccess(decoderPost)
      }
    }
    
    
    func loadPosts(onSuccess: @escaping(_ posts: [Post]) -> Void) {
        Ref.FIRESTORE_COLLECTION_ALL_ASKS.order(by: "date", descending: true).getDocuments { (snapshot, error) in
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
    
    func loadTimeline(onSuccess: @escaping(_ posts: [Post]) -> Void, newPost: @escaping(Post) -> Void, deletePost: @escaping(Post) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelinePosts").order(by: "date", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                   return
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                    var posts = [Post]()
                      print("type: added")
                      let dict = documentChange.document.data()
                      guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                      newPost(decoderPost)
                      posts.append(decoderPost)
                      onSuccess(posts)
                  case .modified:
                      print("type: modified")
                  case .removed:
                      print("type: removed")
                      let dict = documentChange.document.data()
                       guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                       deletePost(decoderPost)
                  }
            }
            
        })
        
        listener(listenerFirestore)
    }
}
