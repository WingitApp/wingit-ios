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


// CONSTANTS

let TIMELINE_PAGINATION_PAGE_SIZE = 10
let TIMELINE_PAGINATION_QUERY = Ref.FS_DOC_TIMELINE_FOR_USERID(
  userId: Auth.auth().currentUser!.uid)
  .collection("timelinePosts")
  .order(by: "date", descending: true)
  .limit(to: 5)

class PostApi {
  
    func postWithoutMedia(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FS_COLLECTION_ALL_POSTS.document().documentID
        let firestorePostRef = Ref.FS_COLLECTION_ALL_POSTS.document(postId)
        let post = Post.init(id: postId, caption: caption, likes: [:], location: "", ownerId: userId, postId: postId, status: .open, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: "", date: Date().timeIntervalSince1970, likeCount: 0, title: "")
        
        do {
            try firestorePostRef.setData(from: post)
            try Ref.FS_COLLECTION_ALL_POSTS.document(postId).setData(from: post)
            onSuccess()
        } catch {
            print(error)
        }
    }
    
    func postWithMedia(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FS_COLLECTION_ALL_POSTS.document().documentID
        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
        
    func deletePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        guard let firestoreMyPostRef = Ref.FS_COLLECTION_POSTS_FOR_USERID(userId: userId)?.document(postId) else { return }
      //  let storagePostRef = Ref.STORAGE_POST_ID
        firestoreMyPostRef.delete { (err) in
            if err != nil{
            //   print(err!.localizedDescription)
                return
            }
            let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
            storagePostRef.delete()
            Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId).delete()
            Ref.FS_COLLECTION_ALL_POSTS.document(postId).delete()
        }
    }
    
        func deleteUserPost(userId: String, postId: String) {
            guard let userId = Auth.auth().currentUser?.uid else {
                return
            }
            guard let firestoreMyPostRef = Ref.FS_COLLECTION_POSTS_FOR_USERID(userId: userId)?.document(postId) else { return }
            firestoreMyPostRef.delete { (err) in
                if err != nil{
               //    print(err!.localizedDescription)
                    return
                }
            Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId).delete()
        }
    }
    
    func hidePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyTimeline = Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId)
        
        firestoreMyTimeline.delete() { (err) in
            if err != nil{
           //    print(err!.localizedDescription)
                return
            }
        }
    }
    
    func loadPost(postId: String, onSuccess: @escaping(_ post: Post) -> Void) {
        Ref.FS_COLLECTION_ALL_POSTS.document(postId).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let snapshot = snapshot {
                let result = Result { try snapshot.data(as: Post.self) }
                    switch result {
                        case .success(let post):
                          if let post = post {
                            onSuccess(post)
                          } else {
                            print("Post document doesn't exist.")
                          }
                        case .failure(let error):
                          // A User could not be initialized from the DocumentSnapshot.
                            printDecodingError(error: error)
                        }
            }
        }
    }
    
    func loadOpenPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        Ref.FS_COLLECTION_ALL_POSTS.whereField("ownerId", isEqualTo: userId).whereField("status", isEqualTo: "open").order(by: "date", descending: true).getDocuments { (snapshot, error) in
            
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
    
    func loadClosedPosts(userId: String?, onSuccess: @escaping(_ posts: [Post]) -> Void) {
        guard let userId = userId else { return }
        Ref.FS_COLLECTION_ALL_POSTS.whereField("ownerId", isEqualTo: userId).whereField("status", isEqualTo: "closed").order(by: "date", descending: true).getDocuments { (snapshot, error) in
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
  
  func loadTimeline(
    next: Query,
    onSuccess: @escaping(_ posts: [Post], _ next: Query) -> Void
  ) -> Void {
      guard let userId = Auth.auth().currentUser?.uid else {return}
      next
        .addSnapshotListener({ (querySnapshot, error) in
          guard let snapshot = querySnapshot else {
            print("Error fetching timeline")
            return
          }
          guard let lastSnapshot = snapshot.documents.last else { return }
          let next = Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId)
            .collection("timelinePosts")
            .order(by: "date", descending: true)
            .limit(to: TIMELINE_PAGINATION_PAGE_SIZE)
            .start(afterDocument: lastSnapshot)
          
          let posts: [Post] = snapshot.documentChanges.compactMap {
            return try? $0.document.data(as: Post.self)
          }
    
          onSuccess(posts, next)
        })
    }
}
