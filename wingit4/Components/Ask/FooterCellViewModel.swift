//
//  FooterCellViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

class FooterCellViewModel: ObservableObject {
  @Published var isLoading = false
  @Published var isLikedByUser = false
    
  func checkPostIsLiked(post: Post) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    if post.likes["\(uid)"] != nil {
      self.isLikedByUser.toggle()
    }
  }
  
  func toggleLike() {
    withAnimation {
      self.isLikedByUser.toggle()
    }
  }

  func like(post: Post) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
      if !self.isLikedByUser {
        // toggles UI
        self.toggleLike()
      }
        var likes = post.likes
        likes[uid] = true
        // TODO : Do all "consistency writes" on Cloud Trigger
        Ref.FS_COLLECTION_ALL_POSTS
          .document(post.postId)
            .updateData(["likes": likes]) { error in
                print(error ?? "")
          }
    Ref.FS_COLLECTION_ALL_POSTS
      .document(post.postId)
        .updateData(["likeCount": post.likeCount]) { error in
            print(error ?? "")
      }
    
        Ref.FS_DOC_TIMELINE_FOR_USERID(userId: uid)
          .collection("timelinePosts")
          .document(post.postId)
            .updateData(["likes": likes]) { error in
                print(error ?? "")
            }
    
        Ref.FS_DOC_TIMELINE_FOR_USERID(userId: uid)
          .collection("timelinePosts")
          .document(post.postId)
            .updateData(["likeCount": post.likeCount]) { error in
                print(error ?? "")
            }
    
        // find connections and update posts in their timeline using Cloud Function
        if Auth.auth().currentUser!.uid != post.ownerId {
          self.createActivityNotification(post: post)
        }
    

    }
  
    
  func unlike(post: Post) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
      if self.isLikedByUser {
        // toggles UI
        self.toggleLike()
      }
        var likes = post.likes
        likes[uid] = false
    // TODO : Do all "consistency writes" on Cloud Trigger
    
        Ref.FS_COLLECTION_ALL_POSTS
          .document(post.postId)
            .updateData(["likes": likes]) { error in
                print(error ?? "")
          }
        Ref.FS_COLLECTION_ALL_POSTS
          .document(post.postId)
            .updateData(["likeCount": post.likeCount]) { error in
                print(error ?? "")
          }

        Ref.FS_DOC_TIMELINE_FOR_USERID(userId: uid)
          .collection("timelinePosts")
          .document(post.postId)
            .updateData(["likes": likes]) { error in
                print(error ?? "")
            }

        Ref.FS_DOC_TIMELINE_FOR_USERID(userId: uid)
          .collection("timelinePosts")
          .document(post.postId)
            .updateData(["likeCount": post.likeCount]) { error in
                print(error ?? "")
            }
    
        if Auth.auth().currentUser!.uid != post.ownerId {
          
          // does this remove the notification from the user's activity feed?
            Ref.FS_COLLECTION_ACTIVITY.document(post.ownerId)
              .collection("feedItems")
              .whereField("type", isEqualTo: "like")
              .whereField("userId", isEqualTo: uid)
              .whereField("postId", isEqualTo:  post.postId)
              .getDocuments { (snapshot, error) in
                if let doc = snapshot?.documents {
                    if let data = doc.first, data.exists {
                        data.reference.delete()
                    }
                }
            }
         }
    }
  
  
  func createActivityNotification(post: Post) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let activityId = Ref.FS_COLLECTION_ACTIVITY
      .document(post.ownerId)
      .collection("feedItems")
      .document()
      .documentID
  
    let activityObject = Activity(
      activityId: activityId,
      type: "like",
      username: Auth.auth().currentUser!.displayName!,
      userId: uid,
      userAvatar: Auth.auth().currentUser!.photoURL!.absoluteString,
      postId: post.postId,
      mediaUrl: post.mediaUrl,
      comment: "",
      date: Date().timeIntervalSince1970
    )
  
    guard let activityDict = try? activityObject.toDictionary() else { return }

    Ref.FS_COLLECTION_ACTIVITY.document(post.ownerId)
      .collection("feedItems")
      .document(activityId)
      .setData(activityDict)
  }

        
}

