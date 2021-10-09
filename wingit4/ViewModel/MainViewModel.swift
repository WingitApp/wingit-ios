//
//  MainViewModel.swift
//  wingit4
//
//  Created by Daniel Yee on 8/4/21.
//

import Amplitude
import Foundation
import Combine
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var tapCount: Int = 0
    @Published var selection: Int = 0
  
  var tabHandler: Binding<Int> { Binding(
    get: { self.selection },
    set: {
      if $0 == self.selection {
        self.tapCount += 1
        }
      Haptic.impact(type: "soft")
      self.selection = $0
    }
  )}
  
  func setTab(tabId: Int) -> Void {
    self.selection = tabId
  }

}
