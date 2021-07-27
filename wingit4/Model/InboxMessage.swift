//
//  InboxMessage.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation


struct InboxMessage: Encodable, Decodable, Identifiable {
    var id = UUID()
    var lastMessage: String
    var username: String
    var type: String
    var date: Double
    var userId: String
    var avatarUrl: String
}
