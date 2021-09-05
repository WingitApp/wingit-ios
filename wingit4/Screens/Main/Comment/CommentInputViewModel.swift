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
    // we return early if there is no logged in user
    guard let isLoggedIn = Auth.auth().currentUser?.uid else { return }
    
    let currentUser = Auth.auth().currentUser

      
    let comment: Comment = Comment(
      id: UUID(),
      comment: text,
      avatarUrl: currentUser!.photoURL!.absoluteString,
      ownerId: currentUser!.uid,
      postId: post.postId,
      username: currentUser!.displayName!,
      date: Date().timeIntervalSince1970
    )
    
    guard let commentDict = try? comment.toDictionary() else {return}
    

    Api.Comment.sendComment(
      commentDict: commentDict,
      postId: post.postId,
      onSuccess: {
            if Auth.auth().currentUser!.uid != post.ownerId {
              // Is this async? If so, there needs to be callback
                let activityId = Ref.FS_COLLECTION_ACTIVITY
                  .document(post.ownerId)
                  .collection("feedItems")
                  .document()
                  .documentID
              
                let activityDict: [String: Any] = [
                  "activityId": activityId,
                  "type": "comment",
                  "username": currentUser!.displayName!,
                  "userId": currentUser!.uid,
                  "userAvatar": currentUser!.photoURL!.absoluteString,
                  "postId": post.postId,
                  "mediaUrl": post.mediaUrl,
                  "comment": text,
                  "date": Date().timeIntervalSince1970
                ]
              
                
                Ref.FS_COLLECTION_ACTIVITY.document(post.ownerId)
                  .collection("feedItems")
                  .document(activityId)
                  .setData(activityDict)
              
                // log to backend
                logToAmplitude(event: .commentOnRec)
              
              onSuccess(comment)

            }
      
        }) { (errorMessage) in
            return
        }
    }
    
}
