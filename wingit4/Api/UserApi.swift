//
//  UserApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

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
    guard let inviteCodeFirstChar = inviteCode.first else { return }
    if let lowercasedUpperBound = Helper.incrementScalarValue(inviteCodeFirstChar.lowercased().unicodeScalars.map { $0.value }.reduce(0, +)) {
      searchForUserByIdPrefix(inviteCode: inviteCode, lowerBound: String(inviteCodeFirstChar.lowercased()), upperBound: lowercasedUpperBound, onSuccess: onSuccess,
          onEmpty: {
            let inviteCodeFirstCharUppercased = inviteCodeFirstChar.convertToUpperCase()
            if !inviteCodeFirstCharUppercased.isNumber {
              if let uppercasedUpperBound = Helper.incrementScalarValue(inviteCodeFirstCharUppercased.unicodeScalars.map { $0.value }.reduce(0, +)) {
                self.searchForUserByIdPrefix(inviteCode: inviteCode, lowerBound: String(inviteCodeFirstCharUppercased), upperBound: uppercasedUpperBound, onSuccess: onSuccess, onEmpty: onEmpty, onError: onError)
              }
            }
          }, onError: onError)
    }
  }
  
  func searchForUserByIdPrefix(inviteCode: String, lowerBound: String, upperBound: String, onSuccess: @escaping(_ user: User) -> Void, onEmpty: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
    Ref.FS_COLLECTION_USERS
      .whereField(FirebaseFirestore.FieldPath.documentID(), isGreaterThanOrEqualTo: lowerBound)
      .whereField(FirebaseFirestore.FieldPath.documentID(), isLessThan: upperBound)
      .getDocuments { (snapshot, error) in
        if let error = error {
          onError(error.localizedDescription)
        } else if let snapshot = snapshot {
          for user in snapshot.documents {
            if user.documentID.prefix(INVITE_CODE_LENGTH).lowercased() == inviteCode.lowercased() {
              let result = Result { try user.data(as: User.self) }
              switch result {
              case .success(let user):
                if let user = user {
                  return onSuccess(user)
                } else {
                  return onEmpty()
                }
              case .failure(let error):
                printDecodingError(error: error)
              }
            }
          }
          onEmpty()
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
  
  func addNames(firstName: String, lastName: String, username: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
    guard let userId = Auth.auth().currentUser?.uid else { return }
    let firstName = firstName.capitalized
    let lastName = lastName.capitalized
    Ref.FS_DOC_USERID(userId: userId).setData(
      ["firstName": firstName,
       "lastName" : lastName,
       "username" : username
      ],
      merge: true)
    
    Api.User.updateKeywords(firstName: firstName, lastName: lastName, username: username)
    
    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
      changeRequest.displayName = firstName + " " + lastName
      changeRequest.commitChanges { (error) in
        if error != nil {
          onError(error!.localizedDescription)
               return
            }
        }
    }
    
    onSuccess()
  }
  
  func updateKeywords(firstName: String, lastName: String, username: String) {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    var keywords = (firstName + lastName).splitStringToArray()
    keywords += username.splitStringToArray()
    print(keywords)
    
    Ref.FS_DOC_USERID(userId: userId).setData(
      ["keywords": keywords],
      merge: true)
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
