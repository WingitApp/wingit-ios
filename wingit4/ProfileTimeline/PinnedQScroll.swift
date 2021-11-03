//
//  PinnedQScrollView.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PinnedQScroll: View {
  
    var body: some View {
      
      ScrollView(.horizontal, showsIndicators: false){
        HStack {
          ForEach(0..<20) { index in
            PinnedQuestion()
           }
        }
      }
      
    }
}

struct PinnedQScroll_Previews: PreviewProvider {
    static var previews: some View {
        PinnedQScroll()
    }
}
