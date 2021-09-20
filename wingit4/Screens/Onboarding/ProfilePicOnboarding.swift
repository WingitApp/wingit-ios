//
//  ProfilePicOnboarding.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/19/21.
//

import SwiftUI

struct ProfilePicOnboarding: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    var body: some View {
        VStack(alignment: .center){
            Text("Add a profile photo")
             .fontWeight(.bold)
            .font(.system(size:30))
            .padding(.horizontal)
            .padding(.bottom, 50)
            .multilineTextAlignment(.center)
            
            VStack(alignment: .center, spacing: 3) {

                UserAvatar(
                  image: signupViewModel.image,
                  height: 65,
                  width: 65,
                  onTapGesture: {
                    self.signupViewModel.isImagePickerShown = true
                  }
                )
                Text("Tap to add photo")
                .modifier(CaptionStyle()).font(.system(size:10))
            }.padding()
            
            
            Button(action: {},
                   label: {
                Text("Upload Photo")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(
                       Color("Color")
                    )
                    .cornerRadius(8)
            })
            Button(action: {},
                   label: {
                    Text("Skip Step").foregroundColor(Color("Color"))
                        .bold()
                        .font(.system(size: 12))
                        .padding(.top)
            })
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

struct ProfilePicOnboarding_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicOnboarding()
    }
}
