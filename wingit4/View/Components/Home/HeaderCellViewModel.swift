//
//  HeaderCellViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//
//

import SwiftUI
import UIKit
import FirebaseAuth

class HeaderCellViewModel : ObservableObject {
    
    // Properties For Image Viewer...
    @Published var selectedImage: String = ""
    @Published var showImageViewer = false
    @Published var user: User!

    var post: Post!
  //  var donepost: DonePost!
    let uid = Auth.auth().currentUser!.uid
    var postId: String?

    func getUserFromPost(postOwnerId: String){
        Api.User.loadUser(userId: postOwnerId) { (user) in
            self.user = user
        }
    }
    
    func blockUser(){
        Api.User.blockUser(userId: uid, postOwnerId: post.ownerId)
        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: post.ownerId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                doc.reference.delete()
              
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: post.ownerId).getDocument { (document, error) in
              if let doc = document, doc.exists {
                  doc.reference.delete()
                 
              }
          }
        
        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(post.ownerId).collection("feedItems").whereField("type", isEqualTo: "follow").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
               if let doc = snapshot?.documents {
                   if let data = doc.first, data.exists {
                       data.reference.delete()
                   }
               }
           }
    }
    
//    func blockUserdone(){
//        Api.User.blockUser(userId: uid, postOwnerId: donepost.ownerId)
//        Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(userId: donepost.ownerId).getDocument { (document, error) in
//            if let doc = document, doc.exists {
//                doc.reference.delete()
//              
//            }
//        }
//        
//        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: donepost.ownerId).getDocument { (document, error) in
//              if let doc = document, doc.exists {
//                  doc.reference.delete()
//                 
//              }
//          }
//        
//        Ref.FIRESTORE_COLLECTION_ACTIVITY.document(donepost.ownerId).collection("feedItems").whereField("type", isEqualTo: "follow").whereField("userId", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
//               if let doc = snapshot?.documents {
//                   if let data = doc.first, data.exists {
//                       data.reference.delete()
//                   }
//               }
//           }
//    }

    
    

}

