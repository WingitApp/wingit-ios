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
    
    var post: Post!
  //  var donepost: DonePost!
    var user: User?
    let uid = Auth.auth().currentUser!.uid
    var postId: String?
    
//    func userToPost(postOwnerId: String){
//        Ref.FIRESTORE_DOCUMENT_USERID(userId: postOwnerId).getDocument { (document, error) inr
//            if let dict = document?.data(), dict. {
//                guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
//              self.userSession = decoderUser
//            }
//        }
//    }
    
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

