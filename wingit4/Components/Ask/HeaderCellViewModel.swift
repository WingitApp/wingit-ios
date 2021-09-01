//
//  HeaderCellViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/2/21.
//
//

import SwiftUI
import UIKit
import FirebaseAuth

class HeaderCellViewModel : ObservableObject {
    
    // Properties For Image Viewer...
    @Published var selectedImage: String = ""
    @Published var showImageViewer = false
    @Published var user: User!

    var post: Post!
  //  var donepost: DonePost!
//  let uid = Auth.auth().currentUser != nil ? Auth.auth().currentUser?.uid : ""
    var postId: String?

    
    
  
}
