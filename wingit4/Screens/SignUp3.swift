//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct SignUp3: View {
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func onUserAvatarTap() {
    self.signupViewModel.isImagePickerShown = true
  }
    var body: some View {
      VStack {
        
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
          .onTapGesture(perform: onUserAvatarTap)

      }
      .sheet(isPresented: $signupViewModel.isImagePickerShown) {
        ImagePicker(
         showImagePicker: self.$signupViewModel.isImagePickerShown,
         pickedImage: self.$signupViewModel.image,
         imageData: self.$signupViewModel.imageData
        )
     }
    }
}

