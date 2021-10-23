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
}
