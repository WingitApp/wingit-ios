//
//  PageCard.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PageCard: View {
    var body: some View {
      Image("Pic1")
      .frame(width: 150, height: 200)
      .cornerRadius(10)
      .padding()
    }
}

struct PageCard_Previews: PreviewProvider {
    static var previews: some View {
        PageCard()
    }
}
