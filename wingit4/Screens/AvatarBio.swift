//
//  SignUp3.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI
import Combine

struct AvatarBio: View {
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
  
  let textLimit = 200
  func limitText(_ upper: Int) {
    if signupViewModel.bioText.count > upper {
      signupViewModel.bioText = String(signupViewModel.bioText.prefix(upper))
         }
     }
  
  func nextButtonBio() {
//      signupViewModel.addBio()
    withAnimation(.easeIn){
      signupViewModel.index = 7}
  }

  
    var body: some View {
      VStack {
        Spacer()
      VStack {
        Text("").padding(35)
          UserAvatarSignup(
            image: signupViewModel.image,
            height: 150,
            width: 150,
            onTapGesture: {
              self.signupViewModel.isImagePickerShown = true
            }
          )
        
        Text("Choose from your photos")
          .font(.body)
          .fontWeight(.semibold)
          .foregroundColor(Color.wingitBlue)
          .padding(.top, 5).padding(.bottom, 25)
          .onTapGesture(perform: onUserAvatarTap)
        
        VStack(alignment: .leading, spacing: 0) {
          
          HStack {
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0){
              Text(
                "\(signupViewModel.bioText.count) / 200 chars"
              )
                .font(.caption)
            }
            .padding(.trailing, 5)
            
            
          }
     
          TextEditor(
            text: $signupViewModel.bioText
          )
            .onReceive(Just(signupViewModel.bioText)) { _ in limitText(textLimit) }
            .padding(15)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.borderGray, lineWidth: 1)
            )
            .frame(height: 200)
//            .padding(.bottom, 30)
         
        }
        .padding([.horizontal])
//        .padding(.vertical, 50)
        .onTapGesture{dismissKeyboard()}
      }
        Spacer()
        HStack{
          Spacer()
        Button(action: { addAvatar() })
        { NextButton()}
        }
     
        
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



