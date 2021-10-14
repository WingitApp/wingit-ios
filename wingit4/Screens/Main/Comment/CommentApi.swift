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
    postId: String?,
    onSuccess: @escaping() -> Void,
    onError: @escaping(_ errorMessage: String) -> Void
  ) {
    guard let postId = postId else { return }
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
  
  func editComment(
    updatedText: String,
    commentId: String?,
    postId: String?,
    onSuccess: @escaping() -> Void
  ) {
    guard let postId = postId,
          let commentId = commentId else {return}
    
    Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId)
      .collection("postComments")
      .document(commentId)
      .updateData([
        "comment": updatedText,
        "updatedAt": Date().timeIntervalSince1970,
        "isEdited": true
      ]) { error in
        if error == nil {
          //handle error
        }
        onSuccess()
      }
  }
  
  
  func deleteComment(
    comment: Comment,
    onSuccess: @escaping() -> Void
  ) {
    guard let postId = comment.postId else { return }
    guard let commentId = comment.docId else { return }
    
    Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId)
     .collection("postComments")
     .document(String(commentId)).delete() { error in
        if error != nil{
          print("error", error as Any)
        } else {
          onSuccess()
        }
     }
  }
    
    
    func getComments(
      postId: String,
      onSuccess: @escaping([Comment]) -> Void,
      onError: @escaping(_ errorMessage: String) -> Void,
      newComment: @escaping(Comment) -> Void,
      onModified: @escaping(Comment) -> Void,
      onRemove: @escaping(Comment) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
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
                  guard let decodedComment = try? documentChange.document.data(as: Comment.self) else { return }
                    onModified(decodedComment)
                case .removed:
                  guard let decodedComment = try? documentChange.document.data(as: Comment.self) else { return }
                    onRemove(decodedComment)
                }
            }
            
            onSuccess(comments)
        }
        
         listener(listenerFirestore)
    }
  
    func getReactionsByComment(
      comment: Comment,
      onEmpty: @escaping() -> Void,
      onSuccess: @escaping([Reaction]) -> Void,
      newReaction: @escaping(Reaction) -> Void,
      modifiedReaction: @escaping(Reaction) -> Void,
      removedReaction: @escaping(Reaction) -> Void,
      listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void
    ) {
      guard let postId = comment.postId else { return }
      guard let commentId = comment.docId else { return }
      
      let listenerReactions = Ref.FS_COLLECTION_REACTIONS_BY_COMMENT(
        postId: postId,
        commentId: commentId
      ).addSnapshotListener { (querySnapshot, error) in
        guard let snapshot = querySnapshot else { return }
        
        if snapshot.documentChanges.isEmpty {
          return onEmpty()
        }
        
        var reactions = [Reaction]()
        
        snapshot.documentChanges.forEach {
            switch $0.type {
            case .added:
                guard let decodedReaction = try? $0.document.data(as: Reaction.self) else { return }
                newReaction(decodedReaction)
                reactions.append(decodedReaction)
            case .modified:
                guard let decodedReaction = try? $0.document.data(as: Reaction.self) else { return }
                modifiedReaction(decodedReaction)
            case .removed:
                guard let decodedReaction = try? $0.document.data(as: Reaction.self) else { return }
                removedReaction(decodedReaction)
            }
        }
        
        onSuccess(reactions)
      }
      
      listener(listenerReactions)
    }
  
  
    func postReaction(
      reactionDict: Dictionary<String, Any>,
      comment: Comment,
      onSuccess: @escaping() -> Void
//      onError: @escaping(_ errorMessage: String) -> Void
    ) {
      guard let postId = comment.postId else { return }
      guard let commentId = comment.docId else { return }

      Ref.FS_COLLECTION_REACTIONS_BY_COMMENT(
        postId: postId,
        commentId: commentId
      )
      .addDocument(data: reactionDict) { error in
        if let error = error {
            print("error: \(error)")
//            onError(error.localizedDescription)
            return
        } else {
//            let activity = UserActivity(activityType: .postComment, commentId: ref?.documentID)
//
//            Api.UserActivity.logActivity(activity: activity)
        }
    
        onSuccess()
        
      }
  }
  
  func addTopCommentStatus(comment: Comment, onSuccess: @escaping() -> Void) {
    guard let postId = comment.postId,
          let commentId = comment.docId
    else {return}
      
      Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId)
        .collection("postComments")
        .document(commentId)
        .updateData(["isTopComment": true]) { error in
        if error != nil {
          return printDecodingError(error: error!)
        } else {
          onSuccess()
        }
      }
    }
  
  func removeTopCommentStatus(postId: String, commentId: String, onSuccess: @escaping() -> Void) {
    Ref.FS_DOC_COMMENTS_FOR_POSTID(postId: postId)
      .collection("postComments")
      .document(commentId)
      .updateData(["isTopComment": nil]) { error in
      if error != nil {
        return printDecodingError(error: error!)
      } else {
        onSuccess()
      }
    }
  }
  
    func addUserReaction(
      reaction: Reaction,
      comment: Comment,
      newReactor: [String: Any],
      onSuccess: @escaping() -> Void
    ) {

      guard let userId = Auth.auth().currentUser?.uid else { return }
      guard let postId = comment.postId else { return }
      guard let commentId = comment.docId else { return }
      guard let reactionId = reaction.docId else { return }

      Ref.FS_COLLECTION_REACTIONS_BY_COMMENT(
        postId: postId,
        commentId: commentId
      )
      .document(reactionId)
      .setData(
        ["reactors": [userId : newReactor]]
        , merge: true
      ) { error in
        if error != nil{
          print("error", error)
        } else {
          onSuccess()
        }
      }
    }
  
     func removeUserReaction(
      reaction: Reaction,
      comment: Comment,
      onSuccess: @escaping() -> Void
     ) {
       guard let userId = Auth.auth().currentUser?.uid else { return }
       guard let postId = comment.postId else { return }
       guard let commentId = comment.docId else { return }
       guard let reactionId = reaction.docId else { return }
        
       // remove user from reactor dictionary
       
       var updatedReactors: [String: Any] = [:]
       
       for (reactorId, userPreview) in reaction.reactors {
         if reactorId != userId {
           guard let userPreviewDict = try? userPreview.toDictionary() else { return }
           updatedReactors[reactorId] = userPreviewDict
         }
       }
       
       Ref.FS_COLLECTION_REACTIONS_BY_COMMENT(
         postId: postId,
         commentId: commentId
       )
       .document(reactionId)
       .updateData(
        ["reactors": updatedReactors]
       ) { error in
         if error != nil{
           print("error", error)
         } else {
           onSuccess()
         }
       }
     }
  
    func deleteReaction(
      reaction: Reaction,
      comment: Comment,
      onSuccess: @escaping() -> Void
    ) {
      guard let postId = comment.postId else { return }
      guard let commentId = comment.docId else { return }
      guard let reactionId = reaction.docId else { return }
      
      Ref.FS_COLLECTION_REACTIONS_BY_COMMENT(
        postId: postId,
        commentId: commentId
      )
        .document(reactionId).delete() { error in
          if error != nil{
            print("error", error)
          } else {
            onSuccess()
          }
        }
    }
}
