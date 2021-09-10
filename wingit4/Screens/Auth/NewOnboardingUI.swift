//
//  NewOnboardingUI.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/9/21.
//

import SwiftUI

struct NewOnboardingUI: View {
    var body: some View {
        // For Smaller Size iPhones...
        
        VStack{
            
            if UIScreen.main.bounds.height < 750{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    Home1()
                }
            }
            else{
                
                Home1()
            }
        }
        .padding(.vertical)
    }
}

struct NewOnboardingUI_Previews: PreviewProvider {
    static var previews: some View {
        NewOnboardingUI()
       // SignUp1()
    }
}


struct Home1 : View {
    
    @State var index = 0
    @Namespace var name
    
    var body: some View{
        
        VStack{
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
            
            HStack(spacing: 0){
                
                Button(action: {
                    
                    withAnimation(.spring()){
                        
                        index = 0
                    }
                    
                }) {
                    
                    VStack{
                        
                        Text("Login")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)
                        
                        ZStack{
                            
                            // slide animation....
                            
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            
                            if index == 0{
                                
                                Capsule()
                                    .fill(Color("Color"))
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
                
                Button(action: {
                    
                    withAnimation(.spring()){
                        
                        index = 1
                    }
                    
                }) {
                    
                    VStack{
                        
                        Text("Sign Up")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)
                        
                        ZStack{
                            
                            // slide animation....
                            
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame( height: 4)
                            
                            if index == 1{
                                
                                Capsule()
                                    .fill(Color("Color"))
                                    .frame( height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
            .padding(.top,30)
            
            // Login View...
            
            // Changing Views Based On Index...
            
            if index == 0{
                
                Login1()
            }
            else{
                
                SignUp1()
            }
        }
    }
}

struct Login1 : View {
    
    @ObservedObject var signinViewModel = SigninViewModel()
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                VStack(alignment: .center, spacing: 12) {
                    
                    Text("Welcome Back")
                        .fontWeight(.bold)
                    
                }
                
      
            }
            .padding(.horizontal,25)
            .padding(.top,30)
            
            VStack(alignment: .leading, spacing: 35) {
            
                EmailTextField(email: $signinViewModel.email)
                PasswordTextField(password: $signinViewModel.password)
                
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            // Login Button....
            
            SigninButton(
             action: signinViewModel.signin,
             label: TEXT_SIGN_IN
            )
            .padding(.horizontal,25)
            .padding(.top,25)
            .alert(isPresented: $signinViewModel.isAlertShown) {
                 Alert(
                     title: Text("Something went wrong..."),
                     message: Text(self.signinViewModel.errorString),
                     dismissButton: .default(Text("OK"))
                 )
             }
            
            
            // Social Buttons...
            
          
//
//            HStack(spacing: 30){
//
//                ForEach(social,id: \.self){name in
//
//                    Button(action: {}) {
//
//                        Image(name)
//                            .renderingMode(.template)
//                            .resizable()
//                            .frame(width: 24,height: 24)
//                            .foregroundColor(Color(name == "google" ? "Color1" : "Color"))
//                    }
//                }
//            }
//            .padding(.top,25)
        }.onTapGesture(perform: dismissKeyboard)
        .onAppear{
            logToAmplitude(event: .viewLoginScreen)
        }
    }
}

var social = ["twitter","fb","google"]

struct SignUp1 : View {
    
    @ObservedObject var signupViewModel = SignupViewModel()
    
    var body: some View{
        
        VStack{
                
                VStack(alignment: .center, spacing: 3) {

                    UserAvatar(
                      image: signupViewModel.image,
                      height: 65,
                      width: 65,
                      onTapGesture: {
                        self.signupViewModel.isImagePickerShown = true
                      }
                    )
                    Text("Tap on picture").foregroundColor(.gray).font(.system(size:10))
                }.padding(.top, 10)
           
            
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
                EmailTextField(
                  email: $signupViewModel.email
                )
                PasswordTextField(
                  password: $signupViewModel.password
                )
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            
            SignupButton(
              action: signupViewModel.signup,
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
            // Social Buttons...
            
//
//            HStack(spacing: 30){
//
//                ForEach(social,id: \.self){name in
//
//                    Button(action: {}) {
//
//                        Image(name)
//                            .renderingMode(.template)
//                            .resizable()
//                            .frame(width: 24,height: 24)
//                            .foregroundColor(Color(name == "google" ? "Color1" : "Color"))
//                    }
//                }
//            }
//            .padding(.top,25)
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

struct EULA1: View {
    var body: some View {
        HStack{
            LINK_TERMS_OF_SERVICE.modifier(LinkStyle())
            Text("and").modifier(CaptionStyle())
            LINK_PRIVACY_POLICY.modifier(LinkStyle())
        }
    }
}
