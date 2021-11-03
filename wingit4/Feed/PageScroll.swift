//
//  PageScroll.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PageScroll: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        Title(title: "Title")
        ScrollView(.horizontal){
          HStack {
            ForEach(0..<20) { index in
              PageCard()
             }
          }
        }
      }
    }
}

struct PageScroll_Previews: PreviewProvider {
    static var previews: some View {
        PageScroll()
    }
}
