//
//  ReportInputViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ReportInputViewModel: ObservableObject {
    
    var post: Post!

   // var donepost: DonePost!
    
    func addReports(text: String, onSuccess: @escaping() -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        guard let username = Auth.auth().currentUser?.displayName else { return }

        Api.Report.sendReport(text: text, username: username, ownerId: currentUserId, postId: post.postId, onSuccess: {
            onSuccess()
        }) { (errorMessage) in
           // print(errorMessage)
        }
    }
    
//    func addDoneReports(text: String, onSuccess: @escaping() -> Void) {
//        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
//        guard let username = Auth.auth().currentUser?.displayName else { return }
//
//        Api.Report.sendDoneReport(text: text, username: username, ownerId: currentUserId, postId: post.postId, onSuccess: {
//            onSuccess()
//        }) { (errorMessage) in
//            print(errorMessage)
//        }
//    }

}
