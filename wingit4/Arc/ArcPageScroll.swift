//
//  ArcPageScroll.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcPageScroll: View {
  
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(0..<20) { index in
            PageCard(width: 250, height: 350)
            TextPreviewCard(width: 200, height: 200, picHeight: 90)
           }.padding(.leading, 5)
        }
      }
    }
}

struct ArcPageScroll_Previews: PreviewProvider {
    static var previews: some View {
        ArcPageScroll()
    }
}
