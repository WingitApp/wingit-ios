//
//  ArcScroll.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct ArcScroll: View {
    var body: some View {
      VStack(alignment: .leading) {
      Title(title: "Title")
        ScrollView(.horizontal) {
          HStack{
          ForEach(0..<20) { index in
            ArcCard()
           }
          }
          }
      }
      
    }
}

struct ArcScroll_Previews: PreviewProvider {
    static var previews: some View {
        ArcScroll()
    }
}

