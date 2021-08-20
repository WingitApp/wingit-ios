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
    func sendComment(text: String, username: String, avatarUrl: String, ownerId: String, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let comment = Comment(comment: text, avatarUrl: avatarUrl, ownerId: ownerId, postId: postId, username: username, date: Date().timeIntervalSince1970)
        guard let dict = try? comment.toDictionary() else {return}
        
        Ref.FIRESTORE_COMMENTS_DOCUMENT_POSTID(postId: postId).collection("postComments").addDocument(data: dict) { (error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            onSuccess()
        }
        
    }
    
    
    func getComments(postId: String, onSuccess: @escaping([Comment]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newComment: @escaping(Comment) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = Ref.FIRESTORE_COMMENTS_DOCUMENT_POSTID(postId: postId).collection("postComments").order(by: "date", descending: false).addSnapshotListener { (querySnapshot, error) in
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
