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
        Ref.FS_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased().removingWhitespaces()).getDocuments { (snapshot, error) in
            if let snap = snapshot {
                let users: [User] = snap.documents.compactMap {
                  return try? $0.data(as: User.self)
                }
                  onSuccess(users)
            }
        }
    }
    
    func loadUser(
        userId: String,
        onSuccess: @escaping(_ user: User) -> Void,
        onError: @escaping() -> Void
        ) {
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
                            onError()
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
    
    func updateImage(imageData: Data, onSuccess: @escaping(_ url: String) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.updateAvatar(userId: userId, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId, onSuccess: onSuccess, onError: onError)
    }
    
    func updateField(field: String, user: User?) {
      return
        if let userId = Auth.auth().currentUser?.uid, let user = user {
            alertView(msg: "Update \(field)") { (txt) in
                if !txt.isEmpty {
                    let capitalized = txt.capitalized
                    if field == "firstName" || field == "lastName" {
                        let displayName = (field == "firstName") ? "\(capitalized) \(user.lastName ?? "")" : "\(user.firstName ?? "") \(capitalized)"
                        StorageService.updateDisplayName(userId: userId, displayName: displayName, onSuccess: { print($0) }, onError: { print($0) })
                        Ref.FS_DOC_USERID(userId: userId).updateData(["keywords": displayName.splitStringToArray()])
                        Ref.FS_DOC_USERID(userId: userId).updateData([field: capitalized, "updatedAt": FieldValue.serverTimestamp()])
                    } else {
                        Ref.FS_DOC_USERID(userId: userId).updateData([field: txt, "updatedAt": FieldValue.serverTimestamp()])
                    }
                }
            }
        }
    }
}
