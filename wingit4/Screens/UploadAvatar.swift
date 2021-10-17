//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct UploadAvatar: View {
  @EnvironmentObject var session: SessionStore
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  func onUserAvatarTap() {
    self.signupViewModel.isImagePickerShown = true
  }
  
  func addAvatar() {
    withAnimation(.easeIn){
      signupViewModel.index = 7}
    //if photo exists go if not still go. so no disable.
    
  }
  
    var body: some View {
      VStack{
        Spacer()
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
     Spacer()
        HStack{
          Spacer()
        Button(action: { addAvatar() })
        { NextButton()}
        }
    } .sheet(isPresented: $signupViewModel.isImagePickerShown) {
      ImagePicker(
       showImagePicker: self.$signupViewModel.isImagePickerShown,
       pickedImage: self.$signupViewModel.image,
       imageData: self.$signupViewModel.imageData
      )
   }
   }
}


