//
//  TinderCard.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

struct TinderCard: View {
  
  @State var referral: Referral
  @State var post: Post?
  @EnvironmentObject var referViewModel: ReferViewModel
  @State private var x: CGFloat = 0.0
  @State private var y: CGFloat = 0.0
  @State private var degree: Double = 0.0
  
 
  
  var body: some View {
    ZStack(alignment: .top){
      
      VStack(spacing: 0){
        TinderHeader(referral: $referral)
//        ReferHeader(referral: $referral)
        TinderBody(post: $post)
      }.cornerRadius(8)
        .environmentObject(referViewModel)
      
      HStack{
        Image("wing.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity((Double(x/10 - 1)))
        Spacer()
        Image("logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity(Double(x/10 * -1 - 1))
      }
    }
    .cornerRadius(8)
      .offset(x: x, y: y)
      .rotationEffect(.init(degrees: degree))
      .gesture(
      DragGesture()
        .onChanged{ value in
          withAnimation(.default){
            x = value.translation.width
            y = value.translation.height
            degree = 7 * (value.translation.width > 0 ? 1 : -1)
          }
          
        }
        .onEnded { value in
          withAnimation(.interpolatingSpring(mass:1.0, stiffness: 50, damping:8,
                                             initialVelocity: 0)) {
            switch value.translation.width {
            case 0...100:
              self.x = 0; degree = 0; y = 0
            case let x where x > 100:
              self.x = 500; degree = 12
            case (-100)...(-1):
              self.x = 0; degree = 0; y = 0;
            case let x where x < -100:
              self.x = -500; degree = -12
            default: x = 0; y = 0
            }
          }
          
        }
      )
  }
}

struct TinderBody: View {
  @EnvironmentObject var referViewModel: ReferViewModel
  @Binding var post: Post?
  let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.7)])
  
  var body: some View {
    ZStack{
      URLImageView(urlString: post?.avatar)
        //.cornerRadius(8)
        .frame(width: 375, height: 375)
       
          LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
        
      VStack{
        HStack{
        VStack(alignment: .leading){
            Text(post?.username ?? "").font(.largeTitle).fontWeight(.bold)
            Text("bio")
        }.padding(.leading, 5)
          Spacer()
        }
        Spacer()
        HStack{
          VStack(alignment: .leading){
            AskCardTag(post: post)
          Text(post?.caption ?? "").bold()
          }
          
          Spacer()
        }
      }
      .padding()
      .foregroundColor(.white)
      
    }
    .frame(width: 375, height: 375)
  }
}
