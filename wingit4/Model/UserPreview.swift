//
//  UserMin.swift
//  wingit4
//
//  Created by Joshua Lee on 10/12/21.
//

import SwiftUI


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// minified user (for slim storage of user metadata)
struct UserPreview: Identifiable, Codable, Equatable, Hashable {
    var id: String?
    var uid: String?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    var username: String?
    var interactedAt: Double?
    var displayName: String? {
      return "\(self.firstName ?? "") \(self.lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines).capitalized
    }
}
