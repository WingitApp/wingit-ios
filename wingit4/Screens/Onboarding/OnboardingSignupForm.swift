//
//  SignupView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 6/9/21.
//

import SwiftUI

struct OnboardingSignupForm : View {
    @Binding var tabSelection: Int
    @EnvironmentObject var session: SessionStore
    @ObservedObject var signupViewModel = SignupViewModel()
    
    var body: some View{
        ZStack{
            GeometryReader{proxy in
                
                let size = proxy.size
                
                // since for opacity animation...
                Color.black
       
                    
                    Image("Pic2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                       
                
                
//                 Linear Gradient...
                        .background(  LinearGradient(
                    gradient: Gradient(
                        colors: [.clear,
                                 .black.opacity(0.5),
                                 .black]),
                    startPoint: .top,
                    endPoint: .bottom)
                    )
        
            }
            .ignoresSafeArea()
        VStack {
            
            Text("Create a Profile").bold().padding(.bottom, 75)
            
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
            .padding(.horizontal, 25)
            SignupButton(
                action: {
                    signupViewModel.signup() { user in
                        self.tabSelection = 1
                        self.session.currentUser = user
                        signupViewModel.onSignupSuccess(user: user)
                    }
                },
              label: TEXT_SIGN_UP
            )
            .padding(.horizontal, 25)
            .padding(.top, 25)
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
    }
        .onTapGesture { dismissKeyboard() }
        .onAppear{ logToAmplitude(event: .viewSignupScreen) }
//        .navigationTitle("Create a Profile")
//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
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
