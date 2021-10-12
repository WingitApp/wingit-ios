//
//  ViewRouter.swift
//  wingit4
//
//  Created by Daniel Yee on 10/10/21.
//

import Foundation
import SwiftUI

enum Screen {
  case askDetail
  case referral
  case userProfile
}

class ViewRouter: ObservableObject {
  static let shared = ViewRouter()
  @Published var currentScreen: Screen?
  @Published var activityId: String?
  @Published var postId: String?
  @Published var userId: String?
  @Published var tapCount: Int = 0
  @Published var tabSelection: MainTab = .home

var tabHandler: Binding<MainTab> { Binding(
  get: { self.tabSelection },
  set: {
    if $0 == self.tabSelection {
      self.tapCount += 1
      }
    Haptic.impact(type: "soft")
    self.tabSelection = $0
  }
)}

func setTab(tab: MainTab) -> Void {
  self.tabSelection = tab
}
}
