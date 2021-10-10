//
//  ViewRouter.swift
//  wingit4
//
//  Created by Daniel Yee on 10/10/21.
//

import Foundation

enum Screen {
  case askDetail
}

final class ViewRouter: ObservableObject {
//  @Published var currentScreen: Screen = .signup
  @Published var tab: MainTab = .notifications
}
