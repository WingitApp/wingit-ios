//
//  ReactionSummaryTab.swift
//  wingit4
//
//  Created by Joshua Lee on 10/13/21.
//

import SwiftUI

struct ReactionSummaryTab: View {
  var index: Int
  var emojiCode: Int
  var namespace: Namespace.ID
  var isActive: Bool
  var onTap: ((Int) -> Void)?
   
  func onTapGesture() -> Void{
    guard let onTap = onTap else {return}
    onTap(index)
  }
  
    var body: some View {
      Button(action: onTapGesture) {
        VStack{
          Text(String(UnicodeScalar(emojiCode)!))
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(isActive ? .black : .gray)
          ZStack{
            Capsule()
              .fill(Color.black.opacity(0.04))
              .frame( height: 4)
            if isActive {
              Capsule()
                .fill(Color("Color"))
                .frame( height: 4)
//                .matchedGeometryEffect(id: "Tab", in: namespace)
            }
          }
        }
      }
    }
}
