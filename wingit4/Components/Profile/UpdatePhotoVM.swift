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

    @Published var image: Image = Image(IMAGE_USER_PLACEHOLDER)
    var imageData: Data = Data(count: 0)
    var errorString = ""

    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    
    func updatePhoto(imageData: Data, completed: @escaping(_ url: String) -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if imageData.count != 0 {
           // showscreen.toggle()
            Api.User.updateImage(imageData: imageData, onSuccess: completed, onError: onError)
        }
        else {
            showAlert = true
            errorString = "Please add a photo to upload"
        }
    }
}
