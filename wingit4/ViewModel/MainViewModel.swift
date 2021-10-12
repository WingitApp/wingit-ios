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

enum MainTab: Hashable {
  case home
  case referrals
  case composePost
  case notifications
  case profile
}

final class MainViewModel: ObservableObject {
    @Published var tapCount: Int = 0
    @Published var selection: MainTab = .home
  
  var tabHandler: Binding<MainTab> { Binding(
    get: { self.selection },
    set: {
      if $0 == self.selection {
        self.tapCount += 1
        }
      Haptic.impact(type: "soft")
      self.selection = $0
    }
  )}
  
  func setTab(tab: MainTab) -> Void {
    self.selection = tab
  }

}
