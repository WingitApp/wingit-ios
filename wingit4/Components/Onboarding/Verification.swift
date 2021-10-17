//
//  Verification.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Verification: View {
  
    @ObservedObject var phoneViewModel : PhoneViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel
    @Environment(\.presentationMode) var present
  
  func verify(){
    withAnimation(.easeIn){
      signupViewModel.index = 5}
    phoneViewModel.verifyCode()
  }
  
    var body: some View {
        
        ZStack{
            
            VStack{

                VStack{
                    
                    HStack{
                      Button(action: {withAnimation(.easeIn){
                        signupViewModel.index = 3}}) {
                          
                          Image(systemName: "arrow.left")
                              .font(.title3)
                              .foregroundColor(.black)
                      }
                      Spacer()
                      VStack(alignment: .center, spacing: 15){
                    Text("Verify Phone #").bold().font(.title2)
                  Text("Code sent to \(phoneViewModel.phoneNo)").font(.caption).foregroundColor(.gray)
                    }
                      Spacer()
                      if phoneViewModel.loading{ProgressView()}
                    }.padding(.top, 50).padding(.horizontal)
                  Spacer()
                  
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
                        
                        Button(action: phoneViewModel.requestCode) {
                            
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
                    
                  Button(action: {verify()})
                            
                  {
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

                CustomNumberPad(value: $phoneViewModel.code, isVerify: true)
            }
            .background(Color("lightGray").ignoresSafeArea(.all, edges: .bottom))
            
            if phoneViewModel.error{
                
                PhoneAlertView(msg: phoneViewModel.errorMsg, show: $phoneViewModel.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // getting Code At Each Index....
    
    func getCodeAtIndex(index: Int)->String{
        
        if phoneViewModel.code.count > index{
            
            let start = phoneViewModel.code.startIndex
            
            let current = phoneViewModel.code.index(start, offsetBy: index)
            
            return String(phoneViewModel.code[current])
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