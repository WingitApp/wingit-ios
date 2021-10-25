//
//  PhoneService.swift
//  wingit4
//
//  Created by Daniel Yee on 10/24/21.
//

import Foundation

class PhoneService {
  func addPhoneNumber(userId: String?, phoneNumber: String?) {
    guard let userId = userId, let phoneNumber = phoneNumber else { return }
    Ref.FS_DOC_USERID(userId: userId).setData(["phoneNumber": phoneNumber], merge: true) { error in
      if error == nil {
        print("error when adding phone number to User")
      }
    }
  }
}
