//
//  SignUp1.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct SignUp1 : View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var signupViewModel: SignupViewModel
    
    var body: some View{
        
        VStack{
           
            ZStack {
                UserAvatarSignup(
                  image: signupViewModel.image,
                  height: 65,
                  width: 65,
                  onTapGesture: {
                    self.signupViewModel.isImagePickerShown = true
                  }
                )
                .zIndex(0)
                Image(systemName: "plus.circle")
                  .font(.system(size: 12))
                  .foregroundColor(.white)
                  .padding(5)
                  .background(
                    LinearGradient(
                      gradient: Gradient(
                        colors: [Color("Color").lighter(by: 10), Color("Color")]),
                        startPoint: .top,
                        endPoint: .bottom
                      )
                  )
                  .cornerRadius(100)
                  .offset(x: 20, y: 20)
                  .frame(width: 20, height: 20)
                  .shadow(
                    color: Color.black.opacity(0.3),
                    radius: 1, x: 0, y: -1
                  )
                  .zIndex(1)

            }
            
            VStack(alignment: .leading, spacing: 15) {
                
                HStack{
                FirstNameTextField(
                  firstName: $signupViewModel.firstName
                )
            
                LastNameTextField(
                  lastName: $signupViewModel.lastName
                )
                }
                UsernameTextField(
                  username: $signupViewModel.username
                )
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            
            SignupButton(
                action: {
                    signupViewModel.signup() { user in
                        signupViewModel.onSignupSuccess(user: user)
                        self.session.currentUser = user
                    }
                },
              label: TEXT_SIGN_UP
            )
            .padding(.horizontal,25)
            .padding(.top,25)
            .alert(
              isPresented: $signupViewModel.isAlertShown
            ) {
                Alert(
                  title: Text("Error"),
                  message: Text(self.signupViewModel.errorString),
                  dismissButton: .default(Text("OK"))
                )
            }
            
            Text("By signing up, you agree to the").padding(.top, 10)
              .modifier(CaptionStyle())
            EULA()
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

