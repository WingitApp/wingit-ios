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
    post: Post,
    onSuccess: @escaping(_ comment: Comment) -> Void
  ) {
    guard let currentUser = Auth.auth().currentUser else { return }

      
    let comment: Comment = Comment(
      comment: text,
      avatarUrl: currentUser.photoURL!.absoluteString,
      ownerId: currentUser.uid,
      postId: post.postId,
      username: currentUser.displayName!,
      date: Date().timeIntervalSince1970,
      type: .askPost
    )
    
    guard let commentDict = try? comment.toDictionary() else {return}
    

    Api.Comment.postComment(
      commentDict: commentDict,
      postId: post.postId,
      onSuccess: {
            if currentUser.uid != post.ownerId {
              // Is this async? If so, there needs to be callback
                let activityId = Ref.FS_COLLECTION_ACTIVITY
                  .document(post.ownerId)
                  .collection("feedItems")
                  .document()
                  .documentID
              
                let notificationDict: [String: Any] = [
                  "activityId": activityId,
                  "type": "comment",
                  "username": currentUser.displayName ?? "",
                  "userId": currentUser.uid,
                  "userAvatar": currentUser.photoURL!.absoluteString,
                  "postId": post.postId,
                  "mediaUrl": post.mediaUrl,
                  "comment": text,
                  "date": Date().timeIntervalSince1970
                ]
              
                Ref.FS_COLLECTION_ACTIVITY.document(post.ownerId)
                  .collection("feedItems")
                  .document(activityId)
                  .setData(notificationDict)
              
                // log to backend
                logToAmplitude(event: .commentOnRec)
              
            }
            onSuccess(comment)
      
        }) { (errorMessage) in
            return
        }
    }
    
}
