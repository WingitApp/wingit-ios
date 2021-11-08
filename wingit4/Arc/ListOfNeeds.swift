//
//  ListOfNeeds.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ListOfNeeds: View {
    var body: some View {
          HStack{
            
            VStack(alignment: .leading, spacing: 10) {
            Text("GOALS")
              .bold()
              .foregroundColor(.gray)
          HStack {
          CheckmarkButton()
          NeedsText()
          }
          HStack {
          CheckmarkButton()
            NeedsText()
          }
          HStack {
          CheckmarkButton()
          NeedsText()
          }
          }
            Spacer()
          }
          .padding(.horizontal, 25)
          .padding(.bottom, 20)
    }
}

struct ListOfNeeds_Previews: PreviewProvider {
    static var previews: some View {
        ListOfNeeds()
    }
}
