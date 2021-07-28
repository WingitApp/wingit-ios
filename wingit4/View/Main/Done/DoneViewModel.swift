//
//  DoneViewModel.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 7/27/21.
//

import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class DoneViewModel: ObservableObject {
    
   
    @Published var caption: String = ""
    @Published var image: Image = Image(systemName: IMAGE_PHOTO)
    var imageData: Data = Data(count: 0)
    var errorString = ""
    
    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    var post: Post!
    var donepost: DonePost!

    @Published var doneposts: [DonePost] = []
    @Published var isLoading = false
    
    func loadDonePosts(userId: String) {
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
    
    func shareDone(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        
        if !caption.isEmpty && imageData.count == 0 {
            Api.Post.uploadDone(caption: caption, imageData: imageData, postId: post.postId, askcaption: post.caption, mediaUrl: post.mediaUrl, asklocation: "", askdate: post.date, onSuccess: completed, onError: onError)
            
          } else if !caption.isEmpty && imageData.count != 0{
            Api.Post.uploadDoneImage(caption: caption, imageData: imageData, postId: post.postId, askcaption: post.caption, mediaUrl: post.mediaUrl, asklocation: "", askdate: post.date, onSuccess: completed, onError: onError)
          } else {
                showAlert = true
                errorString = "Please fill in all fields"
          }
    }
}
