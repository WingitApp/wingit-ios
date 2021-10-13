//
//  Bio.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct Bio: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 5){
        Spacer()
        Text("Bio").bold().font(.title).padding(.bottom, 25)
         Text("Bio").foregroundColor(.gray)
         Divider().padding(.bottom, 50)
        Spacer()
        HStack(alignment: .center){
          Spacer()
          Button(action: {}){
          Text("Skip").padding()
          }
          Spacer()
        }
        
        NextButton()
        
      }.padding()
    }
}
