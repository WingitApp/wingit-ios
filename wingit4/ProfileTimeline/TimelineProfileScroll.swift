//
//  TimelineDatesScroll.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct TimelineProfileScroll: View {
    var body: some View {
      ScrollView(showsIndicators: false) {
        VStack {
        ForEach(0..<20) { index in
          ProfileCardTimeline()
         }
        }
      }
    }
}

struct TimelineDatesScroll_Previews: PreviewProvider {
    static var previews: some View {
        TimelineProfileScroll()
    }
}
