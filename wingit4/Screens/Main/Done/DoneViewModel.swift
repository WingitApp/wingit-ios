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
    let uid = Auth.auth().currentUser!.uid

    @Published var doneposts: [DonePost] = []
    @Published var isLoading = false
    
    func loadDonePosts(userId: String) {
        isLoading = true
        Api.User.loadDonePosts(userId: userId) { (doneposts) in
            self.isLoading = false
            self.doneposts = doneposts
        }
    }
}
