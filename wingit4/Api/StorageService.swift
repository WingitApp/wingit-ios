//
//  StorageService.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

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
                      
                      Ref.FS_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document(messageId).setData(dict) { (error) in
                          if error == nil {
                               Ref.FS_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(dict)
                              
                              let inboxMessage1 = InboxMessage(lastMessage: "PHOTO", username: recipientUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: recipientAvatarUrl)
                              let inboxMessage2 = InboxMessage(lastMessage: "PHOTO", username: senderUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: senderAvatarUrl)

                              guard let inboxDict1 = try? inboxMessage1.toDictionary() else { return }
                              guard let inboxDict2 = try? inboxMessage2.toDictionary() else { return }

                              Ref.FS_DOC_INBOX_DICTIONARY_BETWEEN(senderId: senderId, recipientId: recipientId).setData(inboxDict1)
                              Ref.FS_DOC_INBOX_DICTIONARY_BETWEEN(senderId: recipientId, recipientId: senderId).setData(inboxDict2)
                              onSuccess()
                          } else {
                              onError(error!.localizedDescription)
                          }
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
                    let firestorePostRef = Ref.FS_COLLECTION_ALL_POSTS.document(postId)
                    let post = Post.init(id: postId, caption: caption, likes: [:], location: "", ownerId: userId, postId: postId, status: .open, username: Auth.auth().currentUser!.displayName!, avatar: Auth.auth().currentUser!.photoURL!.absoluteString, mediaUrl: metaImageUrl, date: Date().timeIntervalSince1970, likeCount: 0, title: "")
            
                    do {
                        try firestorePostRef.setData(from: post)
                        try Ref.FS_DOC_TIMELINE_FOR_USERID(userId: userId).collection("timelinePosts").document(postId).setData(from: post)
                        onSuccess()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    
    }
    
    static func saveUser(userId: String, firstName: String, lastName: String, username: String, email: String, imageData: Data, metadata: StorageMetadata, storageAvatarRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
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
                            changeRequest.displayName = firstName + " " + lastName
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                   onError(error!.localizedDescription)
                                   return
                                }
                            }
                        }
                                                    
                        let firestoreUserDoc = Ref.FS_DOC_USERID(userId: userId)
                        // profileImageUrl should be default if user didn't upload photo
                        let profileImageUrl = imageData.count == 0 ? DEFAULT_PROFILE_AVATAR : metaImageUrl
                        let user = User.init(id: userId, uid: userId, bio: "", canonicalEmail: email, email: email, firstName: firstName, keywords: (firstName + lastName).splitStringToArray(), lastName: lastName, profileImageUrl: profileImageUrl, username: username)

                        do {
                            try firestoreUserDoc.setData(from: user) { _ in
                                // todo: handle error if throws
                                onSuccess(user)
                            }
                        } catch {
                            print(error)
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

                        let firestoreUserId = Ref.FS_DOC_USERID(userId: userId)
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
    
    static func updateDisplayName(userId: String, displayName: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            changeRequest.displayName = displayName
            changeRequest.commitChanges { (error) in
                if error != nil {
                   onError(error!.localizedDescription)
                   return
                }
            }
        }
    }
}
