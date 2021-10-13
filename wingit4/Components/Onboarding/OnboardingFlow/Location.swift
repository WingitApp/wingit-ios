//
//  Location.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Location: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 5){
        Text("Location").bold().font(.title).padding(.bottom, 25)
         Text("Location").foregroundColor(.gray)
         Divider().padding(.bottom, 35)
        NextButton()
      }.padding()
    }
}
