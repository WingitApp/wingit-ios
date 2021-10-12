//
//  CommentInputViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class CommentInputViewModel: ObservableObject {
        
    
  func saveComment(
    text: String,
    post: Post?,
    onSuccess: @escaping() -> Void
  ) {
    guard let currentUser = Auth.auth().currentUser, let post = post else { return }
      
    let commentDict = [
      "id": UUID().uuidString,
      "comment": text,
      "avatarUrl": currentUser.photoURL!.absoluteString,
      "ownerId": currentUser.uid,
      "postId": post.postId,
      "username": currentUser.displayName!,
      "date": Date().timeIntervalSince1970,
      "type": CommentType.askPost.rawValue
    ] as [String : Any]
        
    logToAmplitude(event: .postComment, properties: [.postId: post.id, .postType: post.type])
    
    Api.Comment.postComment(
      commentDict: commentDict,
      postId: post.postId,
      onSuccess: {
          guard let ownerId = post.ownerId else { return }
            if currentUser.uid != ownerId {
                let activityId = Ref.FS_COLLECTION_ACTIVITY
                  .document(ownerId)
                  .collection("feedItems")
                  .document()
                  .documentID
              
                let notificationDict: [String: Any] = [
                  "activityId": activityId,
                  "type": "comment",
                  "username": currentUser.displayName ?? "",
                  "userId": currentUser.uid,
                  "userAvatar": currentUser.photoURL?.absoluteString ?? "",
                  "postId": post.postId ?? "",
                  "mediaUrl": post.mediaUrl ?? "",
                  "comment": text,
                  "date": Date().timeIntervalSince1970
                ]
              
                Ref.FS_COLLECTION_ACTIVITY.document(ownerId)
                  .collection("feedItems")
                  .document(activityId)
                  .setData(notificationDict)
            }
            onSuccess()
      
        }) { (errorMessage) in
            return
        }
    }
    
}
