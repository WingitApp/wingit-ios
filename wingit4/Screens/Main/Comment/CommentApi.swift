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
class CommentApi {
    
  func sendComment(
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
//            for document in snapshot.documents {
//                let dict = document.data()
//                guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
//                comments.append(decoderComment)
//                print("comment data")
//                print(decoderComment.comment)
//            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                    let dict = documentChange.document.data()
                    guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
                    newComment(decoderComment)
                    comments.append(decoderComment)
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
