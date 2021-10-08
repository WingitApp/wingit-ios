//
//  TinderAsk.swift
//  wingit4
//
//  Created by Amy Chun on 10/8/21.
//

import SwiftUI

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


struct TinderAsk_Previews: PreviewProvider {
    static var previews: some View {
        TinderAsk()
    }
}
