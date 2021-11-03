//
//  Feed.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct Feed: View {
    var body: some View {
    ScrollView {
        ArcScroll()
        PageScroll()
        PageScroll()
        PageScroll()
      }
      
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
