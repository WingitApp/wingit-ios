//
//  gemPostModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/1/21.
//

import Foundation
import SwiftUI


struct gemPost: Encodable, Decodable {
    var caption: String
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
}



