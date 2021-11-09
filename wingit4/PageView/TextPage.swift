//
//  TextPage.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextPage: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        HStack {
        DateComponent()
          Spacer()
        Image(systemName: "star")
            .foregroundColor(.gray)
        }
        TextUpdateView(width: 345, height: .infinity)
      }
      .padding()
      .background(Color.white)
      .frame(width: 370)
    }
}

struct TextPage_Previews: PreviewProvider {
    static var previews: some View {
      TextPageView()
    }
}

