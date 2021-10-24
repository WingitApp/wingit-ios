//
//  OnboardingV2.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI

struct OnboardingCarousel: View {
  
  @State var offset: CGFloat = 0
  @State var screenIndex: CGFloat = 0
  var onEnd: () -> Void
  
  // getting Rotation...
  func getRotation()->Double{
    
    let progress = offset / (getScreenBounds().width * 4)
    
    // Doing one full rotation...
    let rotation = Double(progress) * 360
    
    return rotation
  }
  
  // Changing BG Color based on offset...
  func getIndex()->Int{
    let progress = (offset / getScreenBounds().width).rounded()
    let index = Int(progress)
    return index
  }
  
  var body: some View {
    
    // Custom Pager View...
    OffsetPageTabView(offset: $offset) {
      
      HStack(spacing: 0){
  
        ForEach(boardingScreens.indices){ index in
          
          VStack(spacing: 15){
            
            Image(boardingScreens[index].image ?? "")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 100)
              .scaleEffect(getScreenBounds().height < 750 ? 0.9 : 1)
              .offset(y: getScreenBounds().height < 750 ? -100 : -120)
            
            OnboardText(screen: boardingScreens[index])
          }
          .padding()
          .frame(width: getScreenBounds().width)
          .frame(maxHeight: .infinity)
          
          
        }
      }
    }
    
    .background(
      
      RoundedRectangle(cornerRadius: 50)
        .fill(.white)
      // Size as image size...
        .frame(width: getScreenBounds().width - 100,height: getScreenBounds().width - 100)
        .scaleEffect(2)
        .rotationEffect(.init(degrees: 25))
        .rotationEffect(.init(degrees: getRotation()))
        .offset(y: -getScreenBounds().width + 20)
      
      ,alignment: .leading
    )
    .background(
      Color("screen\(getIndex() + 1)")
        .animation(.easeInOut, value: getIndex())
    )
    // animating...
    .ignoresSafeArea(.container, edges: .all)
    .overlay(
      VStack{
        HStack{
          Button {
            if getIndex() > 0 {
              offset = min(offset - getScreenBounds().width,getScreenBounds().width * 3)
            }
          } label: {
            Text("Back")
              .fontWeight(.semibold)
              .foregroundColor(.white)
          }
          
          .opacity(getIndex() > 0 ? 1 : 0)
          .allowsHitTesting(getIndex() > 0)
          .frame(width: UIScreen.main.bounds.width / 3.5)
          
          
          HStack(spacing: 8){
            ForEach(boardingScreens.indices,id: \.self){index in
              Circle()
                .fill(.white)
                .opacity(index == getIndex() ? 1 : 0.4)
                .frame(width: 8, height: 8)
                .scaleEffect(index == (getIndex()) ? 1.3 : 0.85)
                .animation(.easeInOut, value: getIndex())
            }
          }
          .frame(maxWidth: .infinity)
          
          Button {
            if getIndex() == 2 {
              onEnd()
            } else {
              offset = min(offset + getScreenBounds().width,getScreenBounds().width * 3)
            }
          } label: {
            Text(getIndex() == 2 ? "Get Started" : "Next")
              .fontWeight(.semibold)
              .foregroundColor(.white)
          }
          .frame(width: UIScreen.main.bounds.width/3.5)
          
        }
        .padding(.top, 30)
        .padding(.horizontal, 8)
      }
        .padding()
      ,
      alignment: .bottom
    )
  }
  
}

