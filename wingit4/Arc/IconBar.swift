//
//  IconBar.swift
//  wingit4
//
//  Created by Amy Chun on 11/9/21.
//

import SwiftUI

struct IconBar: View {
    var body: some View {
      HStack {
        Spacer()
        Image(systemName: "bookmark.fill")
        Image(systemName: "heart")
        Image(systemName: "flag")
      }
      .foregroundColor(.white)
    }
}

struct IconBar_Previews: PreviewProvider {
    static var previews: some View {
        IconBar()
    }
}
