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
              createdAt: nil,
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
}
