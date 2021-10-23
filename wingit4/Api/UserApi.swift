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
  
  func findUser(inviteCode: String, onSuccess: @escaping(_ user: User) -> Void, onEmpty: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
    // Firestore does not have .where(startsWith: String)
    let codeLastChar = inviteCode.last
    if let upperBoundLastChar = Helper.incrementScalarValue(codeLastChar?.unicodeScalars.map { $0.value }.reduce(0, +)) {
      let inviteCodeUpperBound = inviteCode.prefix(5) + upperBoundLastChar
      Ref.FS_COLLECTION_USERS
        .whereField(FirebaseFirestore.FieldPath.documentID(), isGreaterThanOrEqualTo: inviteCode)
        .whereField(FirebaseFirestore.FieldPath.documentID(), isLessThan: inviteCodeUpperBound)
        .getDocuments { (snapshot, error) in
          if let error = error {
            onError(error.localizedDescription)
          } else if let snapshot = snapshot {
            let result = Result { try snapshot.documents.first?.data(as: User.self) }
            switch result {
            case .success(let user):
              if let user = user {
                onSuccess(user)
              } else {
                print("User document doesn't exist.")
                onEmpty()
              }
            case .failure(let error):
              // A User could not be initialized from the DocumentSnapshot.
              onEmpty()
              printDecodingError(error: error)
            }
          }
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
    
    func editProfile(
        bio: String,
        onSuccess: @escaping() -> Void
      ) {
          guard let userId = Auth.auth().currentUser?.uid else {
              return
          }
          
        Ref.FS_DOC_USERID(userId: userId).updateData(["bio": bio]) { error in
          
          if error == nil {
            onSuccess()
          }
        }
          
      }
    
//    func editProfile(
//        first: String,
//        last: String,
//        username: String,
//        bio: String,
//        onSuccess: @escaping() -> Void
//      ) {
//          guard let userId = Auth.auth().currentUser?.uid else {
//              return
//          }
//          if first != "" {
//              Ref.FS_DOC_USERID(userId: userId).updateData([ "firstName" :  first])
//          } else if last != "" {
//              Ref.FS_DOC_USERID(userId: userId).updateData([ "lastName" :  last])
//          } else if username != "" {
//              Ref.FS_DOC_USERID(userId: userId).updateData([ "username" :  username])
//          } else if bio != "" {
//              Ref.FS_DOC_USERID(userId: userId).updateData([ "bio" :  first])
//          } else {
//              return
//          }
//          }
    
    
  func addLink(type: String, link: String, onSuccess: @escaping (_ link: String) -> Void) {
      guard let userId = Auth.auth().currentUser?.uid else {return}
      Ref.FS_DOC_USERID(userId: userId).setData(["\(type)": link], merge: true) { error in
          if error == nil {
            onSuccess(link)
          }
        }
    }
    
    func updateField(field: String, user: User?) {
      return
        // temporarily disabled
//        if let userId = Auth.auth().currentUser?.uid, let user = user {
//            alertView(msg: "Update \(field)") { (txt) in
//                if !txt.isEmpty {
//                    let capitalized = txt.capitalized
//                    if field == "firstName" || field == "lastName" {
//                        let displayName = (field == "firstName") ? "\(capitalized) \(user.lastName ?? "")" : "\(user.firstName ?? "") \(capitalized)"
//                        StorageService.updateDisplayName(userId: userId, displayName: displayName, onSuccess: { print($0) }, onError: { print($0) })
//                        Ref.FS_DOC_USERID(userId: userId).updateData(["keywords": displayName.splitStringToArray()])
//                        Ref.FS_DOC_USERID(userId: userId).updateData([field: capitalized, "updatedAt": FieldValue.serverTimestamp()])
//                    } else {
//                        Ref.FS_DOC_USERID(userId: userId).updateData([field: txt, "updatedAt": FieldValue.serverTimestamp()])
//                    }
//                }
//            }
//        }
    }
}
