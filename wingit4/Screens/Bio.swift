//
//  Bio.swift
//  wingit4
//
//  Created by Amy Chun on 10/14/21.
//

import SwiftUI
import Combine

struct Bio: View {
  
//  @State var bioText: String
  @EnvironmentObject var signupViewModel: SignupViewModel
  
  let textLimit = 200
  func limitText(_ upper: Int) {
    if signupViewModel.bioText.count > upper {
      signupViewModel.bioText = String(signupViewModel.bioText.prefix(upper))
         }
     }
    func nextButtonBio() {
      withAnimation(.easeIn){
        signupViewModel.index = 7}
      signupViewModel.addBio()
    }
 
  
    var body: some View {
      VStack{
        Spacer()
      VStack(alignment: .leading, spacing: 0) {
        Text("").padding(.bottom, 50)
        HStack {
          Text("Include a short Bio")
            .bold()
            .padding(.bottom, 10)
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
          .padding(.bottom, 30)
       
      }
      .padding([.horizontal])
      .padding(.vertical, 50)
        Spacer()
        HStack{
          
          Spacer()
          
        Button(action: { nextButtonBio() })
        { NextButton()}
        }
    }
    }
}

