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
    @ServerTimestamp var createdAt: Timestamp?
    var appVersion: String
    var model: String
    var OSVersion: String?
    var platform: Platform
    var pushNotificationsEnabled: Bool
    var pushNotificationToken: String?
    var userId: String?
}

enum Platform: String, Codable {
    case ios
}

enum DeviceUserDefaultKeys: String {
    case id = "id"
}
