//
//  Verification.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct VerifyPhoneNumber: View {
    @EnvironmentObject var phoneViewModel : PhoneViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel
    @Environment(\.presentationMode) var present
  
  func verify() {
    phoneViewModel.verifyCode() {
      withAnimation(.easeIn) {
        signupViewModel.index = 4
      }
    }
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
                        
                        ForEach(0..<6,id: \.self){ index in
                            
                            // displaying code....
                            
                            DigitInputView(digit: getDigitAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal,20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6){
                        
                        Text("Didn't receive code?")
                            .foregroundColor(.gray)
                        
                        Button(action: phoneViewModel.requestCode ) {
                            
                            Text("Request again")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    
//                    Button(action: {}) {
//
//                        Text("Get via call")
//                            .fontWeight(.bold)
//                            .foregroundColor(.black)
//                    }
//                    .padding(.top,6)
                    
                  Button(action: verify)
                  {
                    Text("Verify and create account")
                      .foregroundColor(.white)
                      .padding(.vertical)
                      .frame(width: UIScreen.main.bounds.width - 30)
                      .background(Color.wingitBlue)
                      .cornerRadius(5)
                  }
                  .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(5)

                CustomNumberPad(value: $phoneViewModel.code, isVerify: true)
            }
            .background(Color("lightGray").ignoresSafeArea(.all, edges: .bottom))
            .alert(isPresented: $phoneViewModel.error){
              Alert(title: Text("Error"),
                    message: Text(self.phoneViewModel.errorMsg),
                    dismissButton: .default(Text("OK"))
              )
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // get a digit at each index
    
    func getDigitAtIndex(index: Int)->String{
        
        if phoneViewModel.code.count > index {
            
            let start = phoneViewModel.code.startIndex
            
            let current = phoneViewModel.code.index(start, offsetBy: index)
            
            return String(phoneViewModel.code[current])
        }
        
        return ""
    }
}

struct DigitInputView: View {
  var digit = ""
  @EnvironmentObject var phoneViewModel : PhoneViewModel
  var body: some View{
    
    VStack(spacing: 10){
      
      Text(digit)
        .textContentType(.oneTimeCode)
        .foregroundColor(.black)
        .font(.title2)
      // default frame...
        .frame(height: 45)
      
      Capsule()
        .fill(Color.gray.opacity(0.5))
        .frame(height: 4)
    }
  }
}
