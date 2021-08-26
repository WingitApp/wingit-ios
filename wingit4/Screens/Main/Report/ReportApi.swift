//
//  ReportApi.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//


import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ReportApi {
    func sendReport(text: String, username: String, ownerId: String, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let report = Report(comment: text, ownerId: ownerId, postId: postId, username: username)
        guard let dict = try? report.toDictionary() else {return}
        
        Ref.FIRESTORE_REPORTS_DOCUMENT_POSTID(postId: postId).collection("reportedReports").addDocument(data: dict) { (error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            onSuccess()
        }
        
    }
    
//    func sendDoneReport(text: String, username: String, ownerId: String, postId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
//        let report = Report(comment: text, ownerId: ownerId, postId: postId, username: username)
//        guard let dict = try? report.toDictionary() else {return}
//        
//        Ref.FIRESTORE_REPORTS_DOCUMENT_POSTID(postId: postId).collection("reportedDoneReports").addDocument(data: dict) { (error) in
//            if let error = error {
//                onError(error.localizedDescription)
//                return
//            }
//            onSuccess()
//        }
//        
//    }
}
