//
//  ProgressBar.swift
//  wingit4
//
//  Created by Amy Chun on 10/22/21.
//

import SwiftUI

struct ProgressBar: View {
  
//  @EnvironmentObject var signupViewModel: SignupViewModel
  var width: CGFloat = 300
  var height: CGFloat = 3
  var percent: CGFloat = 0
  
    var body: some View {
      
      let multiplier = width / 100
      
      VStack{
      ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 5, style: .continuous)
          .frame(width: width, height: height)
        .foregroundColor(Color.black.opacity(0.1))
        
        RoundedRectangle(cornerRadius: 20, style: .continuous)
          .frame(width: percent * multiplier, height: height)
          .foregroundColor(Color.wingitBlue)
      } .animation(.spring())
        Spacer()
      }.padding(.top, 50)
       
    }
}


