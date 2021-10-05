//
//  SocialLink.swift
//  wingit4
//
//  Created by Joshua Lee on 10/2/21.
//


import Foundation
import FirebaseAuth

struct UserSocial: Encodable, Decodable {
    var name: String
    var url: String?
}
