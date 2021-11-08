//
//  ArcPageScroll.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcPageScroll: View {
    var body: some View {
      ScrollView(.horizontal){
        HStack {
          ForEach(0..<20) { index in
            ArcPageCard()
           }
        }
      }
    }
}

struct ArcPageScroll_Previews: PreviewProvider {
    static var previews: some View {
        ArcPageScroll()
    }
}
