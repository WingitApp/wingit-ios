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
  
    func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").document().documentID
        let firestorePostRef = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").document(postId)
        let post = Post.init(caption: caption, likes: [:], location: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: "", date: Date().timeIntervalSince1970, likeCount: 0)
        guard let dict = try? post.toDictionary() else {return}
        
        firestorePostRef.setData(dict) { (error) in
            if error != nil {
              onError(error!.localizedDescription)
              return
            }
            Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId).setData(dict)
            Ref.FS_COLLECTION_ALL_POSTS.document(postId).setData(dict)
            onSuccess()
        }
       
    }
    
    func uploadImage(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").document().documentID
        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
        
    func deletePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyPostRef = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").document(postId)
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
    
    func uploadDoneImage(caption: String, imageData: Data, postId: String, askcaption: String, mediaUrl: String, asklocation: String, askdate: Double, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        self.deleteUserPost(userId: userId, postId: postId)
        let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.savePostDonePhoto(userId: userId, caption: caption, postId: postId, askcaption: askcaption, mediaUrl: mediaUrl, asklocation: asklocation, askdate: askdate, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
    func uploadDone(caption: String, imageData: Data, postId: String, askcaption: String, mediaUrl: String, asklocation: String, askdate: Double, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        self.deleteUserPost(userId: userId, postId: postId)
        let firestorePostRef = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("donePosts").document(postId)
        let donepost = DonePost.init(caption: caption, doneMediaUrl: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, donedate: Date().timeIntervalSince1970, askcaption: askcaption, mediaUrl: mediaUrl, asklocation: asklocation, askdate: askdate)
        guard let dict = try? donepost.toDictionary() else {return}

        firestorePostRef.setData(dict) { (error) in
            if error != nil {
              onError(error!.localizedDescription)
              return
            }
            Ref.FS_COLLECTION_ALL_DONE.document(postId).setData(dict)
            onSuccess()
        }
    }
    
        func deleteUserPost(userId: String, postId: String){
            guard let userId = Auth.auth().currentUser?.uid else {
                return
            }
            let firestoreMyPostRef = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("userPosts").document(postId)
            firestoreMyPostRef.delete { (err) in
                if err != nil{
               //    print(err!.localizedDescription)
                    return
                }
            Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId).delete()
                
            
        }
    }

    
    func deleteDonePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyPostRef = Ref.FS_DOC_POSTS_FOR_USERID(userId: userId).collection("donePosts").document(postId)
      //  let storagePostRef = Ref.STORAGE_POST_ID
        firestoreMyPostRef.delete { (err) in
            if err != nil{
                //print(err!.localizedDescription)
                return
            }
            let storagePostRef = Ref.STORAGE_POST_ID(postId: postId)
            storagePostRef.delete()
            Ref.FS_COLLECTION_ALL_DONE.document(postId).delete()
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
        Ref.FS_COLLECTION_ALL_POSTS.document(postId).getDocument { (snapshot, error) in
          guard let snap = snapshot else {
              print("Error fetching post")
              return
          }
         
              let dict = snap.data()
              guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
              
            onSuccess(decoderPost)
      }
    }
    
    
    func loadPosts(onSuccess: @escaping(_ posts: [Post]) -> Void) {
        Ref.FS_COLLECTION_ALL_POSTS.order(by: "date", descending: true).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching posts")
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
          
          var posts = [Post]()

          snapshot.documentChanges.forEach { (documentChange) in
            let dict = documentChange.document.data()
            guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
            posts.append(decoderPost)
          }
          onSuccess(posts, next)
        })
    }
    
    
//    Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId)
//      .collection("timelinePosts")
//      .order(by: "date", descending: true)
//      .limit(to: 10)
//      .getDocuments { (snapshot, error) in
//        if let doc = snapshot?.documents {
//          print("LOAD MORE DOC: \(doc)")
//        }
//    }

//  }
    
//    func loadTimeline(
//      onSuccess: @escaping(_ posts: [Post],_ lastVisible: DocumentSnapshot) -> Void,
//      newPost: @escaping(Post) -> Void,
//      deletePost: @escaping(Post) -> Void,
//      listener: @escaping(_ listenerHandle: ListenerRegistration
//    ) -> Void) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//                return
//        }
//        let listenerFirestore =  Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId)
//          .collection("timelinePosts")
//          .order(by: "date", descending: true)
//          .limit(to: 10)
//          .addSnapshotListener({ (querySnapshot, error) in
//            guard let snapshot = querySnapshot else { return }
//            snapshot.documentChanges.forEach { (documentChange) in
//              // grab last document snapshot
//              let lastVisible = snapshot.documents[snapshot.documents.count - 1]
//                switch documentChange.type {
//                case .added:
//                  var posts = [Post]()
//                    let dict = documentChange.document.data()
//                    guard let decoderPost = try?
//                            Post.init(fromDictionary: dict)
//                    else {return}
//
////                      newPost(decoderPost)
//                    posts.append(decoderPost)
//                    onSuccess(posts, lastVisible)
//                case .modified:
//                    print("type: modified")
//                case .removed:
//                    let dict = documentChange.document.data()
//                     guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
//                     deletePost(decoderPost)
//                }
//            }
//
//        })
//
//        listener(listenerFirestore)
//    }
}
