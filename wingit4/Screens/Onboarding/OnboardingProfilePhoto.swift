//
//  OnboardingProfilePhoto.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/19/21.
//

import FirebaseAuth
import SwiftUI

struct OnboardingProfilePhoto: View {
  //  @Binding var selectedTab: Int
    @StateObject var updatePhotoVM = UpdatePhotoVM()
    @AppStorage("currentPage") var currentPage = 2
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
           Text("Add a profile photo")
            .fontWeight(.bold)
            .font(.system(size:30))
            .padding(.horizontal)
            .padding(.top, 50)
            .padding(.bottom, 50)
            .multilineTextAlignment(.center)
            
            UserAvatar(
              image: updatePhotoVM.image,
              height: 200,
              width: 200,
              onTapGesture: {
                self.updatePhotoVM.showImagePicker = true
              }
            )
            .padding(.bottom, 50)

            Button(action: { updateProfilePhoto() },
                   label: {
                Text("Continue")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(
                       Color("Color")
                    )
                    .cornerRadius(8)
            })
            .alert(
              isPresented: $updatePhotoVM.showAlert
            ) {
                Alert(
                  title: Text("Error"),
                  message: Text(self.updatePhotoVM.errorString),
                  dismissButton: .default(Text("OK"))
                )
            }
            Button(action: {  withAnimation(.easeInOut){
                currentPage = 3
            } },
               label: {
                Text("Skip Step").foregroundColor(Color("Color"))
                    .bold()
                    .font(.system(size: 16))
                    .padding(.top)
            })
        }
        .environmentObject(updatePhotoVM)
        .navigationTitle("Profile Photo")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .sheet(isPresented: $updatePhotoVM.showImagePicker) {
           ImagePicker(
            showImagePicker: self.$updatePhotoVM.showImagePicker,
            pickedImage: self.$updatePhotoVM.image,
            imageData: self.$updatePhotoVM.imageData
           )
        }
    }
    
    func updateProfilePhoto() {
        updatePhotoVM.updatePhoto(imageData: updatePhotoVM.imageData, completed: {
            withAnimation(.easeInOut){
               currentPage = 3
           }
        }) { (errorMessage) in
            self.updatePhotoVM.showAlert = true
            self.updatePhotoVM.errorString = errorMessage
        }
    }
}

