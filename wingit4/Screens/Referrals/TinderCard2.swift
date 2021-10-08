//
//  TinderCard2.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

struct TinderCard2: View {
  @State var card: Card
  let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.7)])
  var body: some View {
    ZStack(alignment: .topLeading){
      
      VStack(spacing: 0){
      TinderHeader()
        ZStack{
      Image(card.imageName)
            .resizable()
            
           
              LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            
          VStack{
            HStack{
            VStack(alignment: .leading){
                Text(card.name).font(.largeTitle).fontWeight(.bold)
                Text(card.bio)
            }.padding(.leading, 5)
              Spacer()
            }
            Spacer()
          
          }
          .padding()
          .foregroundColor(.white)
          
        }
        .frame(width: 375, height: 375)
        HStack{
          VStack(alignment: .leading){
            Text("Assistance")
              .fontWeight(.heavy)
              .kerning(1)
              .font(.system(size: 9))
              .foregroundColor(Color(red: 255 / 255, green: 179 / 255, blue: 71 / 255))
              .padding(
                EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
              )
              .background(Color(red: 255 / 255, green: 245 / 255, blue: 230 / 255))
              .cornerRadius(5)
              //.overlay(RoundedRectangle(cornerRadius: 5))
//                            .stroke(backgroundColor().darker(by: 4), lineWidth: 1))
              .clipped()
//                  .shadow(color: Color(red: 255 / 255, green: 245 / 255, blue: 230 / 255).darker(by: 4).opacity(0.5), radius: 2, x: 0, y: 0)
          Text("I NEED to know where good pizza places are").bold()
          }
          
          Spacer()
        }.padding(.vertical).padding(.leading, 10)
      }.cornerRadius(8)
     
      
      HStack{
        Image("logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity((Double(card.x/10 - 1)))
        Spacer()
        Image("logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity(Double(card.x/10 * -1 - 1))
      }
    }
    
    
    .cornerRadius(8)
      .offset(x: card.x, y: card.y)
      .rotationEffect(.init(degrees: card.degree))
      .gesture(
      DragGesture()
        .onChanged{ value in
          withAnimation(.default){
            card.x = value.translation.width
            card.y = value.translation.height
            card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
          }
          
        }
        .onEnded { value in
          withAnimation(.interpolatingSpring(mass:1.0, stiffness: 50, damping:8,
                                             initialVelocity: 0)) {
            switch value.translation.width {
            case 0...100:
              card.x = 0; card.degree = 0; card.y = 0
            case let x where x > 100:
              card.x = 500; card.degree = 12
            case (-100)...(-1):
              card.x = 0; card.degree = 0; card.y = 0;
            case let x where x < -100:
              card.x = -500; card.degree = -12
            default: card.x = 0; card.y = 0
            }
          }
          
        }
      )
  }
}

struct TinderCard2_Previews: PreviewProvider {
    static var previews: some View {
        TinderScreen()
    }
}

