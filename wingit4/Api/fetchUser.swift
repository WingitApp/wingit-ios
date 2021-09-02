//
//  fetchUser.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//

//import Foundation
//import SwiftUI
//import Firebase
//
//// Global Refernce
//
//func fetchUser(userId: String, completion: @escaping (User) -> ()) {
//    Ref.FIRESTORE_DOCUMENT_USERID(userId: userId).getDocument{
//    (doc, err) in
//    guard let user = doc else{return}
//    
//    let uid = user.documentID
//    let email = user.data()?["email"] as! String
//    let profileImageUrl = user.data()?["profileImageUrl"] as! String
//    let username = user.data()?["username"] as! String
//    let bio = user.data()?["bio"] as! String
//    let keywords = user.data()?["keywords"] as! [String]
//    
//    DispatchQueue.main.async {
//        completion(User(uid: uid, email: email, profileImageUrl: profileImageUrl, username: username, bio: bio, keywords: keywords))
//       }
//    }
//}
