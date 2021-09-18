//
//  ProfileInformation.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth
import URLImage

struct ProfileInformation: View {
    
    var user: User?
    let currentUser = Auth.auth().currentUser
    @State var updatePic : Bool = false
    
    var body: some View {
        
        VStack{
            if user != nil && self.user!.id == currentUser?.uid {
                
                Button(action: {updatePic.toggle()},
                       label: {
                        URLImageView(urlString: user?.profileImageUrl)
                           .frame(width: 450, height: 330)
                           .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
            
                       }).padding(.leading, -15).padding(.trailing, -15)
                HStack {
                    Button(action: {Api.User.updateField(field: "firstName", user: user)}) {
                        Text(user?.firstName ?? "").font(.title).bold().foregroundColor(Color.black)
                    }
                    
                    Button(action: {Api.User.updateField(field: "lastName", user: user)}) {
                        Text(user?.lastName ?? "").font(.title).bold().foregroundColor(Color.black)
                    }
                }
                             
                Button(action: {Api.User.updateField(field: "bio", user: user)}) {
                  
                Text(user?.bio ?? "").font(.caption).foregroundColor(.gray)
                    }
            } else {
                URLImageView(urlString: user?.profileImageUrl)
                  .frame(width: 430, height: 330)
                  .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
                  
                Text(user?.displayName ?? "").font(.title).bold().foregroundColor(Color.black)
                Text(user?.bio ?? "").font(.caption).foregroundColor(.gray)
            }
            
        }.sheet(isPresented: $updatePic, content: {
            ProfilePicToggle(user: user)
        })
    }
}

struct ProfilePicToggle: View {
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    @EnvironmentObject var profileViewModel: ProfileViewModel
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
  
    func closeSheet() {
      self.profileViewModel.isUpdatePicSheetOpen.toggle()
      self.clean()
    }
    
    func clean() {
        self.updatePhotoVM.image = Image(systemName: IMAGE_USER_PLACEHOLDER)
        self.updatePhotoVM.imageData = Data()
    }
    
    var body: some View {
        
        VStack{
          VStack(alignment: .trailing) {
            HStack {
              Spacer()
              CloseButton(onTap: closeSheet)
            }
          }
          Spacer()

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
            })
              .padding(.vertical)
              .padding(.horizontal)
              .alert(isPresented: $updatePhotoVM.showAlert) {
                  Alert(
                    title: Text("Error"),
                    message: Text(self.updatePhotoVM.errorString),
                    dismissButton: .default(Text("OK"))
                  )
              }
          Spacer()

        }.sheet(isPresented: $updatePhotoVM.showImagePicker) {
            // ImagePickerController()
             ImagePicker(showImagePicker: self.$updatePhotoVM.showImagePicker, pickedImage: self.$updatePhotoVM.image, imageData: self.$updatePhotoVM.imageData)
         }
    }
}

