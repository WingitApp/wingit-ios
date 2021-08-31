//
//  ProfileInfo.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/27/21.
//

import SwiftUI
import FirebaseAuth
import URLImage

struct ProfileInfo: View {
    
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    @State var updatePic : Bool = false
    
    var body: some View {
        
        VStack{
            if user != nil && self.user!.uid == uid{
                
                Button(action: {updatePic.toggle()},
                       label: {
                        URLImage(URL(string: user!.profileImageUrl)!,
                        content: {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                               
                        })
                           .frame(height: 330)
                           .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
            
                       }).padding(.leading, -15).padding(.trailing, -15)
                
               
            } else {
                URLImage(URL(string: user!.profileImageUrl)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                }).frame(width: 100, height: 100)
                
            }
            
        }.sheet(isPresented: $updatePic, content: {
            ProfilePicToggle(user: user)
        })
    }
}

struct ProfilePictureToggle: View {
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    @ObservedObject var updatePhotoVM = UpdatePhotoVM()
    
    func addAvatar() {
        updatePhotoVM.updatePhoto(imageData: updatePhotoVM.imageData, completed: { (user) in
            self.clean()
            // Switch to the Main App
        }) { (errorMessage) in
            self.updatePhotoVM.showAlert = true
            self.updatePhotoVM.errorString = errorMessage
            self.clean()
        }
    }
    
//    func updateAvatar() {
//        updatePhotoVM.updatePhoto(completed: {self.clean()}) {
//            return
//        } onError: { (errorMessage) in
//            self.updatePhotoVM.showAlert = true
//            self.updatePhotoVM.errorString = errorMessage
//            self.clean()
//        }
//    }
////
    func clean() {
        self.updatePhotoVM.image = Image(systemName: IMAGE_USER_PLACEHOLDER)
        self.updatePhotoVM.imageData = Data()
    }
    
    var body: some View {
        
        VStack{
           Text("Change your photo")
                    updatePhotoVM.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .onTapGesture {self.updatePhotoVM.showImagePicker = true}
            Button(action: {addAvatar()},
                   label: {
                Text("Done")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                    .frame(width: 150, height: 50)
                    .background(Color(.systemTeal))
                    .cornerRadius(8)
         }).padding(.vertical).padding(.horizontal)
                .alert(isPresented: $updatePhotoVM.showAlert) {
                    Alert(title: Text("Error"), message: Text(self.updatePhotoVM.errorString), dismissButton: .default(Text("OK")))
                }
        }.sheet(isPresented: $updatePhotoVM.showImagePicker) {
            // ImagePickerController()
             ImagePicker(showImagePicker: self.$updatePhotoVM.showImagePicker, pickedImage: self.$updatePhotoVM.image, imageData: self.$updatePhotoVM.imageData)
         }
    }
}
