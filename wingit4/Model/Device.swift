//
//  Device.swift
//  wingit4
//
//  Created by Daniel Yee on 8/31/21.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

struct Device: Codable {
    @DocumentID var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    var appVersion: String
    var model: String
    var platform: Platform
    var pushNotificationsEnabled: Bool
    var pushNotificationToken: String
    var userId: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdTime
        case appVersion
        case model
        case platform
        case pushNotificationsEnabled
        case pushNotificationToken
        case userId
    }
}

enum Platform: String, Codable {
    case ios
}
