//
//  PageView.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PageView: View {
  
  @State var showText: Bool = false
  
  func toggle(){
    self.showText.toggle()
  }
  
    var body: some View {
      
      ZStack{
      GeometryReader { proxy in
        
        let size = proxy.size
        
        Image("Pic2")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size.width, height: size.height)
        
      }
          .ignoresSafeArea()
        
        VStack(spacing: 10) {
          HStack{
          Button(action: {}){
          Image(systemName: "chevron.left").foregroundColor(.white)
            }
          
            Spacer()
          Text("Page Title")
              .foregroundColor(.white)
              .bold()
            Spacer()
          }.padding(.horizontal)
          Spacer()
          HStack{
            Spacer()
          VStack(spacing: 15) {
            PageViewButton(icon: "heart",
                           function: nil)
            PageViewButton(icon: "arrowshape.turn.up.forward.fill",
                           function: nil)
            PageViewButton(icon: "message.fill",
                           function: nil)
          }
          }.padding()
          Button(action: toggle){
            Image(systemName: self.showText ? "chevron.down" : "chevron.up").foregroundColor(.white)
          }
          if showText {
            PageScroll()
          }
        }
//        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
       
      }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}


/*
 if no image then just text slide.
 else replace both image and text.
 
 if video or pic non existent, then default video or pic or the previous one.
 
 - default may be easier.
 
 */
