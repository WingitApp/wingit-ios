//
//  Tab.swift
//  wingit4
//
//  Created by Amy Chun on 10/22/21.
//

import SwiftUI

struct ProgressNumber: View {
  
  @EnvironmentObject var signupViewModel: SignupViewModel
  var index: Int = 0
  var page: String = ""
  var title: String = ""
  
  var body: some View {
    Button(action: {

      withAnimation(.spring()){

        signupViewModel.index = index
      }

    }) {

      VStack {

        ZStack(alignment: .center){
          
          Image(systemName: "circle.fill")
            .foregroundColor(Color.gray)
            .font(.title)
      //      .font(.caption)
          
          Text(page)
            .font(.caption)
            .foregroundColor(.white)
          
          if signupViewModel.index == index {

            ZStack{
            Image(systemName: "circle.fill")
              .foregroundColor(Color.wingitBlue)
              .font(.title)
        //      .font(.caption)
            
            Text(page)
              .font(.caption)
              .foregroundColor(.white)
            }
            
           }
          Capsule()
           .fill(Color.clear)
           .frame( height: 3)
        }
        
        Text(title)
          .font(.caption2)
          .foregroundColor(signupViewModel.index == index ? .black : .gray)

      }
    }
    
  }
}

