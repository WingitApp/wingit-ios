//
//  StorageService.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import Firebase

class StorageService {
    
    static func saveChatPhoto(messageId: String, senderId: String, senderUsername: String, senderAvatarUrl: String, recipientId: String, recipientAvatarUrl: String, recipientUsername: String, imageData: Data, metadata: StorageMetadata, storageChatRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        storageChatRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
              if error != nil {
                  onError(error!.localizedDescription)
                  return
              }
            storageChatRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let chat = Chat(messageId: messageId, textMessage: "", avatarUrl: senderAvatarUrl, photoUrl: metaImageUrl, senderId: senderId, username: senderUsername, date: Date().timeIntervalSince1970, type: "PHOTO")
                      
                      guard let dict = try? chat.toDictionary() else { return }
                      
                      Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document(messageId).setData(dict) { (error) in
                          if error == nil {
                               Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(dict)
                              
                              let inboxMessage1 = InboxMessage(lastMessage: "PHOTO", username: recipientUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: recipientAvatarUrl)
                              let inboxMessage2 = InboxMessage(lastMessage: "PHOTO", username: senderUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: senderAvatarUrl)

                              guard let inboxDict1 = try? inboxMessage1.toDictionary() else { return }
                              guard let inboxDict2 = try? inboxMessage2.toDictionary() else { return }

                              Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: senderId, recipientId: recipientId).setData(inboxDict1)
                              Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: recipientId, recipientId: senderId).setData(inboxDict2)
                              onSuccess()
                          } else {
                              onError(error!.localizedDescription)
                          }
                      }
                    
                }
            }
        }
        
    }
    
    static func saveGemPhoto(userId: String, caption: String, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
               
        storagePostRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
              if error != nil {
                  onError(error!.localizedDescription)
                  return
              }
            storagePostRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = Ref.FIRESTORE_GEM_POSTS_DOCUMENT_USERID(userId: userId).collection("gemPosts").document(postId)
                    let gempost = gemPost.init(caption: caption, ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970)
                    guard let dict = try? gempost.toDictionary() else {return}
                    
                    firestorePostRef.setData(dict) { (error) in
                        if error != nil {
                          onError(error!.localizedDescription)
                          return
                        }
                        Ref.FIRESTORE_TIMELINE_DOCUMENT_USERID(userId: userId).collection("timelineGemPosts").document(postId).setData(dict)
                        Ref.FIRESTORE_COLLECTION_ALL_GEMS.document(postId).setData(dict)
                        onSuccess()
                    }
                    
                }
            }
        }
    
    }
    
    
    static func savePostPhoto(userId: String, caption: String, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
               
        storagePostRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
              if error != nil {
                  onError(error!.localizedDescription)
                  return
              }
            storagePostRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").document(postId)
                    let post = Post.init(caption: caption, likes: [:], location: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0)
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
            }
        }
    
    }
    
    static func savePostDonePhoto(userId: String, caption: String, postId: String, askcaption: String, mediaUrl: String, asklocation: String, askdate: Double, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
               
        storagePostRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
              if error != nil {
                  onError(error!.localizedDescription)
                  return
              }
            storagePostRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("donePosts").document(postId)
                    let post = DonePost.init(caption: caption, doneMediaUrl: metaImageUrl, ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, donedate: Date().timeIntervalSince1970, askcaption: askcaption, mediaUrl: mediaUrl, asklocation: asklocation, askdate: askdate)
                
                    guard let dict = try? post.toDictionary() else {return}
                    
                    firestorePostRef.setData(dict) { (error) in
                        if error != nil {
                          onError(error!.localizedDescription)
                          return
                        }
                        Ref.FIRESTORE_COLLECTION_ALL_DONE.document(postId).setData(dict)
                        onSuccess()
                    }
                    
                }
            }
        }
    
    }

    
    static func saveAvatar(userId: String, username: String, bio: String, email: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
           storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
            guard let userId = Auth.auth().currentUser?.uid else { return }
                
                storageAvatarRef.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                            changeRequest.photoURL = url
                            changeRequest.displayName = username
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                   onError(error!.localizedDescription)
                                   return
                                }
                            }
                        }
                                                    
                        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
//                        let userInfor = ["username": self.username, "email": self.email, "profileImageUrl": metaImageUrl]
                        let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: bio, keywords: username.splitStringToArray()) 

                        guard let dict = try? user.toDictionary() else {return}
//
//                        guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
//                        print(decoderUser.username)
                        
                        firestoreUserId.setData(dict) { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            onSuccess(user)
                        }
                    }
                }
                
            }
    }
    
    static func updateAvatar(userId: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
           storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
            storageAvatarRef.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                            changeRequest.photoURL = url
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                   onError(error!.localizedDescription)
                                   return
                                }
                            }
                        }

                        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(userId: userId)
                        firestoreUserId.updateData(["profileImageUrl" : metaImageUrl]){
                            (error) in
                                if error != nil {
                                    onError(error!.localizedDescription)
                                    return
                                }
                        }
                                                    
                    }
                }
                
            }
    }

}
