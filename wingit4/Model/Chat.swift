//
//  Chat.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import FirebaseAuth

struct Chat: Encodable, Decodable {
    var messageId: String
    var textMessage: String
    var avatarUrl: String
    var photoUrl: String
    var senderId: String
    var username: String
    var date: Double
    var type: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser!.uid == senderId
    }
    var isPhoto: Bool {
        return type == "PHOTO"
    }
    var isTextMessage: Bool {
        return type == "TEXT"
    }
}
