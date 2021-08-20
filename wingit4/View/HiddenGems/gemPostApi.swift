//
//  gemPostApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/1/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class gemPostApi {
   
    
    func uploadPost(caption: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let postId = Ref.FIRESTORE_GEM_POSTS_DOCUMENT_USERID(userId: userId).collection("gemPosts").document().documentID
        
        let storagePostRef = Ref.STORAGE_GEM_POST_ID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.saveGemPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
   
    
    func deletePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyPostRef = Ref.FIRESTORE_GEM_POSTS_DOCUMENT_USERID(userId: userId).collection("gemPosts").document(postId)
     
        firestoreMyPostRef.delete { (err) in
            if err != nil{
            //   print(err!.localizedDescription)
                return
            }
            let storagePostRef = Ref.STORAGE_GEM_POST_ID(postId: postId)
            storagePostRef.delete()
        }
    }
    
    func hidePost(userId: String, postId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let firestoreMyTimeline = Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelineGemPosts").document(postId)
        
        firestoreMyTimeline.delete() { (err) in
            if err != nil{
           //    print(err!.localizedDescription)
                return
            }
        }
    }
    
    func loadPost(postId: String, onSuccess: @escaping(_ gempost: gemPost) -> Void) {
        Ref.FIRESTORE_COLLECTION_ALL_GEMS.document(postId).getDocument { (snapshot, error) in
          guard let snap = snapshot else {
           //  print("Error fetching data")
              return
          }
              let dict = snap.data()
              guard let decodergemPost = try? gemPost.init(fromDictionary: dict) else {return}
              
            onSuccess(decodergemPost)
      }
    }

    func loadPosts(onSuccess: @escaping(_ gemposts: [gemPost]) -> Void) {
        Ref.FIRESTORE_COLLECTION_ALL_GEMS.order(by: "date", descending: true).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
             //   print("Error fetching data")
                return
            }
            var gemposts = [gemPost]()
            for document in snap.documents {
                let dict = document.data()
                guard let decodergemPost = try? gemPost.init(fromDictionary: dict) else {return}
                gemposts.append(decodergemPost)
                
                
            }
            onSuccess(gemposts)
        }
    }
    
    
    func loadTimeline(onSuccess: @escaping(_ gemposts: [gemPost]) -> Void, newPost: @escaping(gemPost) -> Void, deletePost: @escaping(gemPost) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
                return
        }
        let listenerFirestore =  Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelineGemPosts").order(by: "date", descending: false).addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                   return
            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                  switch documentChange.type {
                  case .added:
                    var gemposts = [gemPost]()
                      let dict = documentChange.document.data()
                      guard let decodergemPost = try? gemPost.init(fromDictionary: dict) else {return}
                      newPost(decodergemPost)
                      gemposts.append(decodergemPost)
                      onSuccess(gemposts)
                  case .modified:
                      print("type: modified")
                  case .removed:
                      let dict = documentChange.document.data()
                       guard let decodergemPost = try? gemPost.init(fromDictionary: dict) else {return}
                       deletePost(decodergemPost)
                  }
            }
            
        })
        
        listener(listenerFirestore)
    }
    
}

