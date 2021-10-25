//
//  Helper.swift
//  wingit4
//
//  Created by Daniel Yee on 10/22/21.
//

import Foundation

class Helper {
  /// Increments a single `UInt32` scalar value
  static func incrementScalarValue(_ scalarValue: UInt32?) -> String? {
    guard let scalarValue = scalarValue, let incrementedValue = UnicodeScalar(scalarValue + 1) else {
      return nil
    }

      return String(Character(incrementedValue))
  }
  
  static func FSDocumentExists(collection: String?, docId: String?, onExists: @escaping() -> Void, onAbsent: @escaping() -> Void) {
    guard let collection = collection, let docId = docId else { return onAbsent() }
    let docRef = Ref.FS_ROOT.collection(collection).document(docId)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        onExists()
      } else {
        onAbsent()
      }
    }
  }
}
