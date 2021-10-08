//
//  Tinder1.swift
//  wingit4
//
//  Created by Amy Chun on 10/6/21.
//

import SwiftUI

struct Tinder1: View {
    var body: some View {
        VStack{
        Text("Hey I think you can help with this")
        Text("Post preview")
            ZStack{
              Image("user-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
                VStack{
                    Spacer()
            HStack{
                Text("wing").padding()
                Spacer()
                VStack{
                Text("Name")
                Text("bio")
                }
                Spacer()
                Text("Accept").padding()
            }.padding()
                }
            }
        }
    }
}

struct TinderHeader: View {
  
  var body: some View {
    
    VStack(alignment: .leading){
      HStack(alignment: .top) {
        Image("user-placeholder")
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.gray, lineWidth: 1)
                )
                .padding([.horizontal])
              
              VStack(alignment: .leading) {
                Group {
                  Text("Sender").fontWeight(.semibold) +
                  Text(" Hey I think you can help her.")
                  Text("5 min ago").font(.caption).foregroundColor(.gray)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
               
              }
              
              Spacer()
//              Button(
//                  action: { },
//                     label: {
//                      Image(systemName: "xmark").foregroundColor(.gray)
//              })
              }
      }
    .cornerRadius(8)
    .background(Color.white)
    .padding(.top, 10)
  }
}

struct TinderAsk: View {
  
  var body: some View {
    
    VStack(alignment: .leading){
      HStack(alignment: .top) {
        Image("user-placeholder")
                .resizable()
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.gray, lineWidth: 1)
                )
                .padding([.horizontal])
              
              VStack(alignment: .leading) {
                Group {
                  Text("Sender").fontWeight(.semibold) +
                  Text(" Hey I think you can help her.")
                  Text("5 min ago").font(.caption).foregroundColor(.gray)
                }
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
              }
              
              Spacer()
//              Button(
//                  action: { },
//                     label: {
//                      Image(systemName: "xmark").foregroundColor(.gray)
//              })
              }
      }
    .cornerRadius(8)
    .background(Color.white)
    .padding(.top, 10)
  }
}



struct Tinder1_Previews: PreviewProvider {
    static var previews: some View {
        Tinder2()
    }
}

struct Tinder2: View {
  
    var body: some View {
      VStack{
     
        ZStack{
          ForEach(Card.data.reversed()) { card in
            TinderCard(card: card).padding(8)
          }
        }.zIndex(1.0)
        
        
        //Bottom
//        HStack{
//
//        }
      }
    }
}

struct TinderCard: View {
  @State var card: Card
  let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
  var body: some View {
    ZStack(alignment: .topLeading){
      
      VStack{
      TinderHeader()
        ZStack{
      Image(card.imageName).resizable().cornerRadius(8).background(
      LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
      ).cornerRadius(8)
          VStack(){
            Spacer()
            VStack(){
                Text(card.name).font(.largeTitle).fontWeight(.bold)
                Text(card.bio)
            }.padding(.leading, 5)
          
          }
          .padding()
          .foregroundColor(.white)
        }
      AskCardPlaceholder()
      }
     
      
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


