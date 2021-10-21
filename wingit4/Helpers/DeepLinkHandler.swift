//
//  DeepLinkHandler.swift
//  wingit4
//
//  Created by Daniel Yee on 10/20/21.
//

import Firebase
import Foundation
import SwiftUI

class DeepLinkHandler {

  enum DeepLink: Equatable {
    case home
    case details(recipeID: String)
  }
  
  func parseComponents(from url: URL) -> DeepLink? {

    guard url.scheme == "https" else {
      return nil
    }
    
    guard url.pathComponents.contains("invite") else {
      return .home
    }
    
    guard let query = url.query else {
      return nil
    }
    
    let components = query.split(separator: ",").flatMap {
      $0.split(separator: "=")
    }
    
    guard let idIndex = components.firstIndex(of: Substring("inviterId")) else {
      return nil
    }
    
    guard idIndex + 1 < components.count else {
      return nil
    }
    
    return .details(recipeID: String(components[idIndex + 1]))
  }
}
