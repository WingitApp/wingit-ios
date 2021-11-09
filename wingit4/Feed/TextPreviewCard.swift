//
//  TextPreviewCard.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextPreviewCard: View {
  
  var width: CGFloat = 200
  var height: CGFloat = 200
  var picHeight: CGFloat = 90
  
    var body: some View {
      ZStack {
        VStack {
        Image("Pic3")
        .resizable()
        .frame(width: 200, height: picHeight)
          Spacer()
        }
        VStack {
          Spacer()
        HStack {
          Spacer()
          TextUpdateView(width: 170, height: 140)
//          .padding(10)
          .cornerRadius(5)
          .lineLimit(7)
        }
        }
      }
      .cornerRadius(10)
      .frame(width: width, height: height)
    }
}

struct TextPreviewCard_Previews: PreviewProvider {
    static var previews: some View {
        TextPreviewCard()
    }
}
