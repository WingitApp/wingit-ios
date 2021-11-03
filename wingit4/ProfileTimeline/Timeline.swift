//
//  Timeline.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct Timeline: View {
    var body: some View {
      
      VStack {
        Image(systemName: "chevron.down")
          .font(.caption)
          .foregroundColor(.gray)
          .padding()
       AvatarPicName()
//       Text("bio")
//          .font(.headline)
       PinnedQScroll()
       TimelineProfileScroll()
      }
      
    }
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
    }
}
