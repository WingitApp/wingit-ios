//
//  ArcPageCard.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcPageCard: View {
  var body: some View {
    Image("Pic1")
    .frame(width: 250, height: 350)
    .cornerRadius(30)
    .padding(.leading, 25)
  }
}

struct ArcPageCard_Previews: PreviewProvider {
    static var previews: some View {
        ArcPageCard()
    }
}
