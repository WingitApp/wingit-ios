//
//  TinderScreen.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

struct TinderScreen: View {
  
    var body: some View {
      VStack{
      //Text("You have 10 wings")
        ZStack{
          ForEach(Card.data.reversed()) { card in
            TinderCard(card: card).padding(8)
//            TinderCard2(card: card).padding(8)
          }
        }.zIndex(1.0)
        
        //Bottom
//        HStack{
//
//        }
      }
    }
}


struct TinderScreen_Previews: PreviewProvider {
    static var previews: some View {
        TinderScreen()
    }
}

