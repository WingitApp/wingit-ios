//
//  DeepLinkKey.swift
//  wingit4
//
//  Created by Daniel Yee on 10/20/21.
//

import SwiftUI

struct DeepLinkKey: EnvironmentKey {
  static var defaultValue: ViewRouter.DeepLink? {
    return nil
  }
}

// MARK: - Define a new environment value property
extension EnvironmentValues {
  var deepLink: ViewRouter.DeepLink? {
    get {
      self[DeepLinkKey]
    }
    set {
      self[DeepLinkKey] = newValue
    }
  }
}
