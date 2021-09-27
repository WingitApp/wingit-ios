//
//  ComposePostViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//


import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class ComposePostViewModel: ObservableObject {
    
    @Published var caption: String = ""
    
    @Published var image: Image = Image(systemName: IMAGE_PHOTO)
    @Published var imageData: Data = Data(count: 0)
    @Published var showImagePicker: Bool = false
    
    var errorString = ""
    
    @Published var showAlert: Bool = false
    @Published var isDisabled: Bool = false
    @Published var selectedPostType: Int = 0

    
    
    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !caption.isEmpty && imageData.count == 0 {
            logToAmplitude(event: .postAsk, properties: [.attachedPhoto: false])
            Api.Post.postWithoutMedia(
              caption: caption,
              type: POST_TYPE_OPTIONS[selectedPostType],
              onSuccess: completed,
              onError: onError
            )
              isDisabled = true
           } else if !caption.isEmpty && imageData.count != 0{
            logToAmplitude(event: .postAsk, properties: [.attachedPhoto: true])
            Api.Post.postWithMedia(
              caption: caption,
              type: POST_TYPE_OPTIONS[selectedPostType],
              imageData: imageData,
              onSuccess: completed,
              onError: onError
            )
            isDisabled = true
          } else {
                showAlert = true
                errorString = "Please fill in all fields"
          }

    }
        
}
