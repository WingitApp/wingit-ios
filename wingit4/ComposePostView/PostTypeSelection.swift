//
//  PostTypeSelection.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct PostTypeSelection: View {
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .center, spacing: 5) {
        Text("NEED")
        Text("TEXT")
        Text("PHOTO").bold()
        Text("VIDEO")
      }
        .foregroundColor(.white)
        .font(.caption)
      }.frame(width: 190)
    }
}

struct PostTypeSelection_Previews: PreviewProvider {
    static var previews: some View {
        PostTypeSelection()
    }
}
