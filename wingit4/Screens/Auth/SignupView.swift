//
//  SignupView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var signupViewModel = SignupViewModel()
 
    var body: some View {
        VStack {
            UserAvatar(
              image: signupViewModel.image,
              height: 80,
              width: 80,
              onTapGesture: {
                self.signupViewModel.isImagePickerShown = true
              }
            )
            Text(IMAGE_UPLOAD_TEXT)
              .modifier(Caption2Style())
              .multilineTextAlignment(.center)
              .padding(.bottom, 40)
            SignUpForm()
            Divider()
            Text(TEXT_SIGNUP_NOTE)
              .modifier(FootNote())
              .padding()
              .lineLimit(nil)
            Text("By signing up, you agree to the")
              .modifier(CaptionStyle())
            EULA()
        }
        .navigationBarTitle("Register", displayMode: .inline)
    }
}

struct EULA: View {
    var body: some View {
        HStack{
            LINK_TERMS_OF_SERVICE.modifier(LinkStyle())
            Text("and").modifier(CaptionStyle())
            LINK_PRIVACY_POLICY.modifier(LinkStyle())
        }
    }
}

struct SignUpForm: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    
  
    var body: some View {
        VStack{
            UsernameTextField(
              username: $signupViewModel.username
            )
            BioTextField(
              bio: $signupViewModel.bio
            )
            EmailTextField(
              email: $signupViewModel.email
            )
            VStack(alignment: .leading) {
                PasswordTextField(
                  password: $signupViewModel.password
                )
                Text(TEXT_SIGNUP_PASSWORD_REQUIRED)
                  .modifier(FootNote())
                  .padding([.leading])
            }
            SignupButton(
              action: signupViewModel.signup,
              label: TEXT_SIGN_UP
            ).alert(
              isPresented: $signupViewModel.isAlertShown
            ) {
                Alert(
                  title: Text("Error"),
                  message: Text(self.signupViewModel.errorString),
                  dismissButton: .default(Text("OK"))
                )
            }
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
        .sheet(isPresented: $signupViewModel.isImagePickerShown) {
           ImagePicker(
            showImagePicker: self.$signupViewModel.isImagePickerShown,
            pickedImage: self.$signupViewModel.image,
            imageData: self.$signupViewModel.imageData
           )
        }
    }
}
