//
//  CommentApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

class CommentApi {
    
  func postComment(
    commentDict: Dictionary<String, Any>,
    postId: String,
    onSuccess: @escaping() -> Void,
    onError: @escaping(_ errorMessage: String) -> Void
  ) {
    var ref: DocumentReference? = nil
    ref = Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId)
      .collection("postComments")
      .addDocument(data: commentDict) { (error) in
        if let error = error {
            print("error: \(error)")
            onError(error.localizedDescription)
            return
        } else {
            let activity = UserActivity(activityType: .postComment, commentId: ref?.documentID)
      
            Api.UserActivity.logActivity(activity: activity)
        }
    
    onSuccess()
    }
  }
    
    
    func getComments(postId: String, onSuccess: @escaping([Comment]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newComment: @escaping(Comment) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId).collection("postComments").order(by: "date", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                return
            }
            
            var comments = [Comment]()
            snapshot.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                    guard let decodedComment = try? documentChange.document.data(as: Comment.self) else { return }
                    newComment(decodedComment)
                    comments.append(decodedComment)
                case .modified:
                    print("type: modified")
                case .removed:
                    print("type: removed")
                }
            }
            
            onSuccess(comments)
        }
        
         listener(listenerFirestore)
    }
}
