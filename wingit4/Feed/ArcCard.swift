//
//  ArcCard.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct ArcCard: View {
    var body: some View {
      Image("Pic1")
      .frame(width: UIScreen.main.bounds.width - 60, height: 250)
      .cornerRadius(10)
      .padding()
    }
}

struct ArcCard_Previews: PreviewProvider {
    static var previews: some View {
        ArcCard()
    }
}
