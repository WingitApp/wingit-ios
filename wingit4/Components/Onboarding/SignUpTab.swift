//
//  FirstView.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct SignUpTab: View {

  @EnvironmentObject var signupViewModel: SignupViewModel
  @Namespace var name
  
    var body: some View {
      
      VStack{
      HStack(spacing: 0){
        
        
        Button(action: {
          
          withAnimation(.spring()){
            
            signupViewModel.index = 1
          }
          
        }) {
          
          VStack{
            
            Text("Names")
              .font(.system(size: 20))
              .fontWeight(.bold)
              .foregroundColor(signupViewModel.index == 1 ? .black : .gray)
            
            ZStack{
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 4)
              
              if signupViewModel.index == 1{
                
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
            
            signupViewModel.index = 2
          }
          
        }) {
          
          VStack{
            
            Text("Email/Pass")
              .font(.system(size: 20))
              .fontWeight(.bold)
              .foregroundColor(signupViewModel.index == 2 ? .black : .gray)
            
            ZStack{
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 4)
              
              if signupViewModel.index == 2{
                
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
            
            signupViewModel.index = 3
          }
          
        }) {
          
          VStack{
            
            Text("Phone #")
              .font(.system(size: 20))
              .fontWeight(.bold)
              .foregroundColor(signupViewModel.index == 3 ? .black : .gray)
            
            ZStack{
              
              // slide animation....
              
              Capsule()
                .fill(Color.black.opacity(0.04))
                .frame( height: 4)
              
              if signupViewModel.index == 3{
                
                Capsule()
                  .fill(Color("Color"))
                  .frame( height: 4)
                  .matchedGeometryEffect(id: "Tab", in: name)
              }
            }
          }
        }
      }
        Spacer()
    }
      .padding(.top,30)
    }
}
