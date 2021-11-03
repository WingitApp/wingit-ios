//
//  PageTimelineView.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/2/21.
//

import SwiftUI

struct PageTimelineView: View {
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false){
      HStack {
      ForEach(0..<20) { index in
        QuestionCard()
       }
      }
    }
//      .rotationEffect(.init(degrees: 90))
//      .frame(height: size.width)
      .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct PageTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        PageTimelineView()
    }
}
