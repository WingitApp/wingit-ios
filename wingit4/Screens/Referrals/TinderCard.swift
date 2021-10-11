//
//  TinderCard.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

struct TinderCard: View {
  
  @State var card: Card

  @State private var x: CGFloat = 0.0
  @State private var y: CGFloat = 0.0
  @State private var degree: Double = 0.0
  
  let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.7)])
  
  var body: some View {
    ZStack(alignment: .topLeading){
      
      VStack(spacing: 0){
      TinderHeader()
        ZStack{
      Image(card.imageName)
            .resizable()
            //.cornerRadius(8)
           
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
            }
          }
          .padding()
          .foregroundColor(.white)
          
        }
        .frame(width: 375, height: 375)
      }.cornerRadius(8)
     
      
      HStack{
        Image("logo")
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
              x = 0; degree = 0; y = 0
            case let x where x > 100:
              self.x = 500; degree = 12
            case (-100)...(-1):
              x = 0; degree = 0; y = 0;
            case let x where x < -100:
              self.x = -500; degree = -12
            default: x = 0; y = 0
            }
          }
          
        }
      )
  }
}

struct TinderCard_Previews: PreviewProvider {
    static var previews: some View {
        TinderScreen()
    }
}




          struct Card: Identifiable {
            let id = UUID()
            let name: String
            let imageName: String
            let age: Int
            let bio: String
            var x: CGFloat = 0.0
            var y: CGFloat = 0.0
            var degree: Double = 0.0
          
          
          static var data: [Card] {
            [
              Card(name: "Rosie", imageName: "Pic1", age: 24, bio: "hi"),
              Card(name: "Rosie", imageName: "Pic2", age: 24, bio: "hi"),
              Card(name: "Rosie", imageName: "Pic3", age: 24, bio: "hi"),
              Card(name: "Rosie", imageName: "Pic2", age: 24, bio: "hi"),
              Card(name: "Rosie", imageName: "Pic1", age: 24, bio: "hi")
            ]
          }
        }

