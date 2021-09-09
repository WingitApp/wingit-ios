//
//  DeviceApi.swift
//  wingit4
//
//  Created by Daniel on 9/2/21.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import Foundation
import UIKit

class DeviceApi {
    
  func createDevice(token: String) {
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
          
            let device = Device(
              id: deviceId,
              createdTime: nil,
              appVersion: UIApplication.appVersion!,
              model: UIDevice().type.rawValue,
              OSVersion: UIDevice().systemVersion,
              platform: .ios,
              pushNotificationsEnabled: true,
              pushNotificationToken: token,
              userId: Auth.auth().currentUser?.uid
            )
                
            do {
                try Ref.FS_COLLECTION_DEVICES.document(deviceId).setData(from: device)
                UserDefaults.standard.set(deviceId, forKey: DeviceUserDefaultKeys.id.rawValue)
            } catch {
                print(error)
            }
        }
    }
    
  func updateDeviceInFirestore(token: String) {
        if let deviceId = UIDevice.current.identifierForVendor?.uuidString {
          
          if token.isEmpty {
            Ref.FS_COLLECTION_DEVICES.document(deviceId).setData(["appVersion": UIApplication.appVersion!, "lastUpdated": FieldValue.serverTimestamp(), "model":  UIDevice().type.rawValue, "OSVersion": UIDevice().systemVersion, "userId": Auth.auth().currentUser?.uid ?? ""], merge: true)
          } else {
            Ref.FS_COLLECTION_DEVICES.document(deviceId).setData(["appVersion": UIApplication.appVersion!, "lastUpdated": FieldValue.serverTimestamp(), "model":  UIDevice().type.rawValue, "OSVersion": UIDevice().systemVersion, "userId": Auth.auth().currentUser?.uid ?? "", "pushNotificationToken": token], merge: true)
          }
          
        }
    }
    
    func searchUsers(text: String, onSuccess: @escaping(_ users: [User]) -> Void) {
       // print(text.lowercased().removingWhitespaces())
        
        Ref.FS_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased().removingWhitespaces()).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
             //   print("Error fetching data")
                return
            }
          //  print(snap.documents)
            var users = [User]()
            for document in snap.documents {
                let dict = document.data()
                guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                if decodedUser.id != Auth.auth().currentUser!.uid {
                    users.append(decodedUser)
                }
                
            }
            onSuccess(users)
        }
    }
    
    func loadUser(userId: String, onSuccess: @escaping(_ user: User) -> Void) {
        Ref.FS_DOC_USERID(userId: userId).getDocument { (snapshot, error) in
            if let error = error {
                print(error)
            } else if let snapshot = snapshot {
                let result = Result { try snapshot.data(as: User.self) }
                    switch result {
                        case .success(let user):
                          if let user = user {
                            onSuccess(user)
                          }
                          else {
                            print("Document doesn't exist.")
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
    
    func updateImage(imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.updateAvatar(userId: userId, imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId, onSuccess: onSuccess, onError: onError)
    }
    
    func updateDetails(field : String) {
        alertView(msg: "Update \(field)") { (txt) in
            if txt != ""{
                self.updateBio(id: field == "Name" ? "username" : "bio", value: txt)
            }
        }
    }
    
    // TODO: Change to updateDevice()
    func updateBio(id: String,value: String){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        Ref.FS_DOC_USERID(userId: userId).updateData([
            id: value,
        ]) { (err) in
            
            if err != nil{return}
            
        }
    }
}
