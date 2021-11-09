//
//  TextPreviewCard.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextPreviewCard: View {
    var body: some View {
      ZStack {
        VStack {
        Image("Pic3")
        .resizable()
        .frame(width: 200, height: 90)
          Spacer()
        }
        VStack {
          Spacer()
        HStack {
          Spacer()
        TextView() 
          .lineLimit(7)
         
        }
        }
      }
      .cornerRadius(10)
      .frame(width: 200, height: 200)
    }
}

struct TextPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        TextPreviewCard()
    }
}
