//
//  Verification.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Verification: View {
  
    @ObservedObject var loginViewModel : LoginViewModel
  @EnvironmentObject var signupViewModel: SignupViewModel
    @Environment(\.presentationMode) var present
  
    var body: some View {
        
        ZStack{
            
            VStack{

                VStack{
                    
                    HStack{
                        
                        Button(action: {withAnimation(.easeIn){
                          signupViewModel.index = 4}}) {
                            
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Verify Phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginViewModel.loading{ProgressView()}
                    }
                    .padding()
                    
                    Text("Code sent to \(loginViewModel.phoneNo)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15){
                        
                        ForEach(0..<6,id: \.self){index in
                            
                            // displaying code....
                            
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6){
                        
                        Text("Didn't receive code?")
                            .foregroundColor(.gray)
                        
                        Button(action: loginViewModel.requestCode) {
                            
                            Text("Request Again")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {}) {
                        
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.top,6)
                    
                    Button(action: loginViewModel.verifyCode) {
                        
                        Text("Verify and Create Account")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.wingitBlue)
                            .cornerRadius(15)
                    }
                    .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)

                CustomNumberPad(value: $loginViewModel.code, isVerify: true)
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
            
            if loginViewModel.error{
                
                LoginAlertView(msg: loginViewModel.errorMsg, show: $loginViewModel.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // getting Code At Each Index....
    
    func getCodeAtIndex(index: Int)->String{
        
        if loginViewModel.code.count > index{
            
            let start = loginViewModel.code.startIndex
            
            let current = loginViewModel.code.index(start, offsetBy: index)
            
            return String(loginViewModel.code[current])
        }
        
        return ""
    }
}

struct CodeView: View {
    
    var code: String
    
    var body: some View{
        
        VStack(spacing: 10){
            
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
            // default frame...
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
