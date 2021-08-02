//
//  gemHeaderViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/20/21.
//

import SwiftUI
import UIKit
import FirebaseAuth

class GemHeaderViewModel : ObservableObject {
    
    // Properties For Image Viewer...
    @Published var selectedImage: String = ""
    @Published var showImageViewer = false
    @Published var user: User!
    
    var gempost: gemPost!
    let uid = Auth.auth().currentUser!.uid
    var userId: String?
    
    func getUserFromPost(postOwnerId: String){
        Api.User.loadUser(userId: postOwnerId) { (user) in
            self.user = user
        }
    }
    
    func blockUser(){
        Api.User.blockUser(userId: uid, postOwnerId: gempost.ownerId)
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: gempost.ownerId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
              
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: gempost.ownerId).getDocument { (document, error) in
              if let doc = document, doc.exists {
                  doc.reference.delete()
                 
              }
          }
        
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(gempost.ownerId).collection("feedItems").whereField("type", isEqualTo: "follow").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
               if let doc = snapshot?.documents {
                   if let data = doc.first, data.exists {
                       data.reference.delete()
                   }
               }
           }
    }

}

