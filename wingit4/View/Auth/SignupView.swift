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
            
            SignUpTextField()
            Divider()
            Text(TEXT_SIGNUP_NOTE).font(.footnote).foregroundColor(.gray).padding().lineLimit(nil)
         
                Text("By signing up, you agree to the").font(.caption).foregroundColor(.gray)
            EULA()
       
        }
        //.sheet(isPresented: $signupViewModel.showscreen, content: { EULA() })
        .navigationBarTitle("Register", displayMode: .inline)
    }
}

struct EULA: View {
    var body: some View {
        HStack{
            LINK_TERMS_OF_SERVICE.font(.caption).foregroundColor(.blue)
            Text("and").font(.caption).foregroundColor(.gray)
            LINK_PRIVACY_POLICY.font(.caption).foregroundColor(.blue)
        }
    }
}

struct SignUpTextField: View {
    @ObservedObject var signupViewModel = SignupViewModel()
    func signUp() {
        signupViewModel.signup(username: signupViewModel.username, bio: signupViewModel.bio, email: signupViewModel.email, password: signupViewModel.password, imageData: signupViewModel.imageData, completed: { (user) in
            print(user.email)
            self.clean()
            // Switch to the Main App
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
            self.signupViewModel.showAlert = true
            self.signupViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func clean() {
        self.signupViewModel.username = ""
        self.signupViewModel.bio = ""
        self.signupViewModel.email = ""
        self.signupViewModel.password = ""
    }
    var body: some View {
        VStack{
            VStack{
            signupViewModel.image.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80)
                .clipShape(Circle())
                .onTapGesture {
                    print("Tapped")
                    self.signupViewModel.showImagePicker = true
            }
                Text("Tap on the image to add a picture :)").font(.caption2).foregroundColor(.gray).multilineTextAlignment(.center)
                Text("Picture is mandatory atm. Hope you can understand! Thank you!").font(.caption2).foregroundColor(.gray).multilineTextAlignment(.center)
            }.padding(.bottom, 40)
            UsernameTextField(username: $signupViewModel.username)
            BioTextField(bio: $signupViewModel.bio)
            EmailTextField(email: $signupViewModel.email)
            VStack(alignment: .leading) {
                PasswordTextField(password: $signupViewModel.password)
                Text(TEXT_SIGNUP_PASSWORD_REQUIRED).font(.footnote).foregroundColor(.gray).padding([.leading])
            }
            SignupButton(action: signUp, label: TEXT_SIGN_UP).alert(isPresented: $signupViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.signupViewModel.errorString), dismissButton: .default(Text("OK")))
            }
        }.onTapGesture { dismissKeyboard() }
        .sheet(isPresented: $signupViewModel.showImagePicker) {
          // ImagePickerController()
           ImagePicker(showImagePicker: self.$signupViewModel.showImagePicker, pickedImage: self.$signupViewModel.image, imageData: self.$signupViewModel.imageData)
       }
    }
}
