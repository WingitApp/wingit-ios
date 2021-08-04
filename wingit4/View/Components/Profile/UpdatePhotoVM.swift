//
//  UpdatePhotoVM.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/1/21.
//
//
import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class UpdatePhotoVM: ObservableObject {

    @Published var image: Image = Image(systemName: IMAGE_PHOTO)
    var imageData: Data = Data(count: 0)
    var errorString = ""

    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    
    func addPhoto(imageData: Data, completed: @escaping(_ user: User) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if imageData.count != 0 {
           // showscreen.toggle()
            Api.User.updateImage(imageData: imageData, onSuccess: completed, onError: onError)
        }
        else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
    }

//    func updatePhoto(completed: @escaping() -> Void, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
//        if imageData.count == 0 {
//            guard let userId = Auth.auth().currentUser?.uid else { return }
//
//            let storageAvatarUserId = Ref.STORAGE_AVATAR_USERID(userId: userId)
//            let metadata = StorageMetadata()
//            StorageService.updateAvatar(imageData: imageData, metadata: metadata, storageAvatarRef: storageAvatarUserId, onSuccess: onSuccess, onError: onError)
//        } else {
//            showAlert = true
//            errorString = "Please include an image"
//      }
//    }

    
//    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
//
//        if !caption.isEmpty && imageData.count == 0 {
//             //AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
//            Api.Post.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
//
//          } else if !caption.isEmpty && imageData.count != 0{
//            Api.Post.uploadImage(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
//          } else {
//                showAlert = true
//                errorString = "Please fill in all fields"
//          }
//
//    }
//    func shareGem(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
//
//        if !caption.isEmpty && !imageData.isEmpty {
//             //AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
//            Api.gemPost.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
//
//          } else {
//              showAlert = true
//              errorString = "Please fill in all fields"
//          }
//
//    }
    
}
