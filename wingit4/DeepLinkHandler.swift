//
//  DeepLinkHandler.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import Foundation

class DeepLinkHandler {
  // DeepLink enum with two cases:
  //  home - for navigating to the home view
  //  details - for navigating to a specific recipe detailed view
  //          - uses the parsed recipeID query from url for navigation
  enum DeepLink: Equatable {
    case home
    case details(recipeID: String)
  }

  // Parse url
  func parseComponents(from url: URL) -> DeepLink? {
    // 1
    guard url.scheme == "https" else {
      return nil
    }
    // 2
    guard url.pathComponents.contains("policy") else {
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
    guard let idIndex = components.firstIndex(of: Substring("postID")) else {
      return nil
    }
    // 6
    guard idIndex + 1 < components.count else {
      return nil
    }
    // 7
    return .details(recipeID: String(components[idIndex + 1]))
  }
}

