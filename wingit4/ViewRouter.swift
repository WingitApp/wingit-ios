//
//  ViewRouter.swift
//  wingit4
//
//  Created by Daniel Yee on 10/10/21.
//

import Foundation
import SwiftUI

enum Screen: Equatable {
  case askDetail
  case home
  case referral
  case userProfile
}

class ViewRouter: ObservableObject {
  
  enum DeepLink: Equatable {
    case home
    case invite(inviterId: String)
  }
  
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
  
  // Parse url
  func parseComponents(from url: URL) -> DeepLink? {
    // 1
    guard url.scheme == "https" else {
      return nil
    }
    // 2
    guard url.pathComponents.contains("invite") else {
      return .home
    }
    // 3
    guard let query = url.query else {
      return nil
    }
    // 4
    let components = query.split(separator: ",").flatMap {
      $0.split(separator: "=")
    }
    // 5
    guard let idIndex = components.firstIndex(of: Substring("inviterId")) else {
      return nil
    }
    // 6
    guard idIndex + 1 < components.count else {
      return nil
    }
    // 7
    return .invite(inviterId: String(components[idIndex + 1]))
  }
}
