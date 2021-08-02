//
//  CameraViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class CameraViewModel: ObservableObject {
    
    @Published var caption: String = ""
    @Published var image: Image = Image(systemName: IMAGE_PHOTO)
    var imageData: Data = Data(count: 0)
    var errorString = ""
    
    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
   
    
    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        
        if !caption.isEmpty && imageData.count == 0 {
             //AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
            Api.Post.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
            
          } else if !caption.isEmpty && imageData.count != 0{
            Api.Post.uploadImage(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
          } else {
                showAlert = true
                errorString = "Please fill in all fields"
          }

    }
    
    func shareGem(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
 
        if !caption.isEmpty && !imageData.isEmpty {
             //AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
            Api.gemPost.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)

          } else {
              showAlert = true
              errorString = "Please fill in all fields"
          }

    }
    
}
