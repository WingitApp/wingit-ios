//
//  DoneViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/22/21.
//

//import Foundation
//import FirebaseAuth
//import Firebase
//import FirebaseStorage
//import SwiftUI
//
//
//class DoneViewModel: ObservableObject {
//    
//    @Published var caption: String = ""
//    @Published var image: Image = Image(systemName: IMAGE_PHOTO)
//    var imageData: Data = Data(count: 0)
//    var errorString = ""
//    
//    @Published var showAlert: Bool = false
//    @Published var showImagePicker: Bool = false
//    
//    var donepost: DonePost!
//   
//    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
//        
//        if !caption.isEmpty && imageData.count == 0 {
//        
//            Api.Post.uploadDone(caption: caption, imageData: imageData, postId: donepost.postId, onSuccess: completed, onError: onError)
//            
//          } else if !caption.isEmpty && imageData.count != 0{
//            Api.Post.uploadDoneImage(caption: caption, imageData: imageData, postId: donepost.postId, onSuccess: completed, onError: onError)
//          } else {
//                showAlert = true
//                errorString = "Please fill in all fields"
//          }
//
//    }
// 
//}
