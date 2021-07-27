//
//  User.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import Foundation

struct User: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    var keywords: [String]
//
//    static func convertDictToUserStruct(dict: [String: Any]) -> User {
//        let bio = dict["bio"] as! String
//        let email = dict["email"] as! String
//        let profileImageUrl = dict["profileImageUrl"] as! String
//        let username = dict["username"] as! String
//        let keywords = dict["keywords"] as! [String]
//        let uid = dict["uid"] as! String
//
//        let user = User.init(uid: uid, email: email, profileImageUrl: profileImageUrl, username: username, bio: bio, keywords: keywords)
//        return user
//    }
}
