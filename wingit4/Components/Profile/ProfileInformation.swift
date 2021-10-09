//
//  ProfileInformation.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI
import FirebaseAuth
import URLImage
import SPAlert


struct UpdateProfilePhoto: View {
    var user: User?
    var onClose: (() -> Void)? = nil
    let uid = Auth.auth().currentUser?.uid
    @State var isSavingPhoto: Bool = false
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var updatePhotoVM: UpdatePhotoVM

    
    func addAvatar() {
        Haptic.impact(type: "soft")
        isSavingPhoto = true
        updatePhotoVM.updatePhoto(imageData: updatePhotoVM.imageData, completed: { url in
            session.currentUser?.profileImageUrl = url
            self.isSavingPhoto = false
            self.closeSheet()
            let alertView = SPAlertView(
              title: "Photo updated!",
              preset: SPAlertIconPreset.done
            );
            alertView.present(duration: 2)
            // Switch to the Main App
        }) { (errorMessage) in
          self.isSavingPhoto = false
            self.updatePhotoVM.showAlert = true
            self.updatePhotoVM.errorString = errorMessage
            self.clean()
        }
    }
  
    func callback() {
      guard let closeCallback = onClose else { return }
      closeCallback()
    }
  
    func revertPhoto() {
        Haptic.impact(type: "soft")
        self.updatePhotoVM.loadCurrentImage(userAvatar: user!.profileImageUrl)
        self.clean()
    }
  
    func openImagePicker() {
      Haptic.impact(type: "soft")
      self.updatePhotoVM.showImagePicker = true
    }
  
    func closeSheet() {
      Haptic.impact(type: "soft")
      self.callback()
      self.session.isUpdatePicSheetOpen = false
      self.clean()
      
    }
    
    func clean() {
        self.updatePhotoVM.imageData = Data(count: 0)
    }
    
    var body: some View {
        
        VStack{
          HStack {
            Button(action: callback) {
              Image(systemName: "chevron.backward")
                  .foregroundColor(.gray)
                  .padding(10)
            }
            .opacity(onClose == nil ? 0 : 1)
            .zIndex(onClose == nil ? -1 : 1)
            Spacer()
            Text("Update Your Photo").bold()
            Spacer()
            CloseButton(onTap: closeSheet)
              .padding(10)

          }
          .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
          Divider()

          Spacer()
          HStack {
            VStack {
              ZStack {
                updatePhotoVM.image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .clipShape(Circle())
                  .frame(width: 200, height: 200)
                  .zIndex(0)
                  .onTapGesture(perform: openImagePicker)
                if !updatePhotoVM.imageData.isEmpty {
                  Text(
                    Image(systemName: "xmark")
                  )
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .cornerRadius(100)
                    .background(
                      LinearGradient(
                        gradient: Gradient(
                          colors: [Color.wingitBlue.lighter(by: 10), Color.wingitBlue]),
                          startPoint: .top,
                          endPoint: .bottom
                        )
                    )
                    .cornerRadius(100)
                    .offset(x: 80, y: -53)
                    .shadow(
                      color: Color.black.opacity(0.3),
                      radius: 1, x: 0, y: -1
                    )
                    .zIndex(1)
                    .onTapGesture(perform: revertPhoto)
                }
              }
     
              Text("Choose from your photos")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(Color.wingitBlue)
                .padding(.top, 5)
                .onTapGesture(perform: openImagePicker)
            }
            .onTapGesture {}
          
          }
          Spacer()
            
            Button(
              action: addAvatar,
              label: {
                HStack {
                  if isSavingPhoto {
                    CircleLoader(size: 20)
                  } else {
                    Text("Save")
                      .fontWeight(.semibold)
                      .foregroundColor(Color.white)
                  }
                 
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .background(Color.wingitBlue)
                .cornerRadius(5)
            })
            
              .opacity((updatePhotoVM.imageData.isEmpty || isSavingPhoto) ? 0.6 : 1)
              .disabled(updatePhotoVM.imageData.isEmpty || isSavingPhoto)
              .padding(.top, 50)
              .padding(.bottom, 15)
              .alert(isPresented: $updatePhotoVM.showAlert) {
                  Alert(
                    title: Text("Error"),
                    message: Text(self.updatePhotoVM.errorString),
                    dismissButton: .default(Text("OK"))
                  )
              }

        }
        .background(Color.white)

        .onDisappear {
          self.clean()
        }
        .sheet(isPresented: $updatePhotoVM.showImagePicker) {
            // ImagePickerController()
             ImagePicker(
                showImagePicker: self.$updatePhotoVM.showImagePicker,
                pickedImage: self.$updatePhotoVM.image,
                imageData: self.$updatePhotoVM.imageData
             )
         }
        .preferredColorScheme(.light)
    }
}

