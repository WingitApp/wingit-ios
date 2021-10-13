//
//  InsertPhoto.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct InsertPhoto: View {
  @EnvironmentObject var session: SessionStore
  @ObservedObject var signupViewModel = SignupViewModel()
    var body: some View {
      VStack(alignment: .leading, spacing: 5){
        Spacer()
       Text("UpdatePhotoView").bold().font(.title).padding(.bottom, 25)
        UserAvatarSignup(
          image: signupViewModel.image,
          height: 200,
          width: 200,
          onTapGesture: {
            self.signupViewModel.isImagePickerShown = true
          }
        )
        Text("Choose from your photos")
          .font(.body)
          .fontWeight(.semibold)
          .foregroundColor(Color.wingitBlue)
          .padding(.top, 5)
        Spacer()
        Button(action: {}){
          Text("Skip")
        }
        NextButton()
      }.padding()
        .sheet(isPresented: $signupViewModel.isImagePickerShown) {
           ImagePicker(
            showImagePicker: self.$signupViewModel.isImagePickerShown,
            pickedImage: self.$signupViewModel.image,
            imageData: self.$signupViewModel.imageData
           )
        }
    }
}
