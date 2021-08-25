//
//  DropDownMenuViewModel.swift
//  wingit4
//
//  Created by Joshua Lee on 8/23/21.
//

import SwiftUI

class EllipsisMenuViewModel: ObservableObject {
  @EnvironmentObject var askCardViewModel: AskCardViewModel
  @Published var isReportModalOpen: Bool = false
  
  func onTapOpenReportScreen() {
    isReportModalOpen.toggle()
  }
  
  func onTapHidePost() {
    let post = askCardViewModel.post!
    Api.Post.hidePost(
      userId: post.ownerId,
      postId: post.postId
    )
  }
  
  func onTapBlockUser() {
    let postOwnerId = askCardViewModel.post!.ownerId
    let userId = askCardViewModel.uid
    
    Api.User.blockUser(userId: userId, postOwnerId: postOwnerId)
    
    Ref.FIRESTORE_COLLECTION_FOLLOWING_USERID(
      userId: postOwnerId
    ).getDocument { (document, error) in
      if let doc = document, doc.exists {
          doc.reference.delete()
      }
    }
      
    Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(
      userId: postOwnerId
    ).getDocument { (document, error) in
      if let doc = document, doc.exists {
        doc.reference.delete()
      }
    }
      
    Ref.FIRESTORE_COLLECTION_ACTIVITY.document(postOwnerId)
    .collection("feedItems")
    .whereField("type", isEqualTo: "follow")
    .whereField("userId", isEqualTo: userId)
    .getDocuments { (snapshot, error) in
      if let doc = snapshot?.documents {
        if let data = doc.first, data.exists {
          data.reference.delete()
        }
      }
    }
  }
}