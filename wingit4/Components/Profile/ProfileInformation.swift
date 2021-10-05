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

//struct ProfileInformation: View {
//
//    var user: User?
//    let currentUser = Auth.auth().currentUser
//    @State var updatePic : Bool = false
//    @EnvironmentObject var session: SessionStore
//
//    var body: some View {
//
//        VStack{
//            if user != nil && self.user!.id == currentUser?.uid {
//
//                Button(action: {updatePic.toggle()},
//                       label: {
//                        URLImageView(urlString: user?.profileImageUrl)
//                           .frame(width: 450, height: 330)
//                           .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
//
//                       }).padding(.leading, -15).padding(.trailing, -15)
//                HStack {
//                    Button(action: {Api.User.updateField(field: "firstName", user: user)}) {
//                        Text(user?.firstName ?? "").font(.title).bold().foregroundColor(Color.black)
//                    }
//
//                    Button(action: {Api.User.updateField(field: "lastName", user: user)}) {
//                        Text(user?.lastName ?? "").font(.title).bold().foregroundColor(Color.black)
//                    }
//                }
//
//                Button(action: {Api.User.updateField(field: "bio", user: user)}) {
//
//                Text(user?.bio ?? "").font(.caption).foregroundColor(.gray)
//                    }
//            } else {
//                URLImageView(urlString: user?.profileImageUrl)
//                  .frame(width: 430, height: 330)
//                  .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
//
//                Text(user?.displayName ?? "").font(.title).bold().foregroundColor(Color.black)
//                Text(user?.bio ?? "").font(.caption).foregroundColor(.gray)
//            }
//
//        }.sheet(isPresented: $updatePic, content: {
//            UpdateProfilePhoto(user: user)
//        })
//        .environmentObject(session)
//    }
//}

struct UpdateProfilePhoto: View {
    var user: User?
    let uid = Auth.auth().currentUser?.uid
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var session: SessionStore
    @ObservedObject var updatePhotoVM = UpdatePhotoVM()
    
    func addAvatar() {
        updatePhotoVM.updatePhoto(imageData: updatePhotoVM.imageData, completed: { url in
            session.currentUser?.profileImageUrl = url
            self.closeSheet()
            let alertView = SPAlertView( title: "Photo updated!", preset: SPAlertIconPreset.done);
            alertView.present(duration: 2)
            // Switch to the Main App
        }) { (errorMessage) in
            self.updatePhotoVM.showAlert = true
            self.updatePhotoVM.errorString = errorMessage
            self.clean()
        }
    }
  
    func revertPhoto() {
        self.updatePhotoVM.loadCurrentImage(userAvatar: user!.profileImageUrl)
        self.clean()
    }
  
    func closeSheet() {
      self.profileViewModel.isUpdatePicSheetOpen.toggle()
      self.clean()
    }
    
    func clean() {
        self.updatePhotoVM.imageData = Data(count: 0)
    }
    
    var body: some View {
        
        VStack{
          Capsule()
           .fill(Color.gray)
           .frame(width: 60, height: 4)
           .padding(.top, 15)
          
            HStack(alignment: .center){
              Text("Update Your Photo")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("bw"))
              Spacer()
              CloseButton(onTap: closeSheet)
            }
            .padding([.horizontal])
            .padding(.top, 5)

          Spacer()
          HStack {
            VStack {
              ZStack {
                updatePhotoVM.image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .clipShape(Circle())
                  .frame(width: 200, height: 200)
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
            }
            .onTapGesture {self.updatePhotoVM.showImagePicker = true}
          
          }
          Spacer()
            
            Button(
              action: {addAvatar()},
              label: {
                HStack {
                  Text("Save")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .background(Color.wingitBlue)
                .cornerRadius(8)
            })
              .opacity(updatePhotoVM.imageData.isEmpty ? 0.6 : 1)
              .disabled(updatePhotoVM.imageData.isEmpty)
              .padding(.top, 50)
              
              .alert(isPresented: $updatePhotoVM.showAlert) {
                  Alert(
                    title: Text("Error"),
                    message: Text(self.updatePhotoVM.errorString),
                    dismissButton: .default(Text("OK"))
                  )
              }

        }
        .onAppear {
          self.updatePhotoVM.loadCurrentImage(userAvatar: user!.profileImageUrl)
        }
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

