//
//  ReferButton.swift
//  wingit4
//
//  Created by Joshua Lee on 8/25/21.
//

import SwiftUI

struct ShareButton: View {
  @ObservedObject var shareButtonViewModel = ShareButtonViewModel()
  @Binding var post: Post
  
    var body: some View {
      Button(
        action: { self.shareButtonViewModel.createDLink(post: post) },
        label: {
          Image(systemName: "arrowshape.turn.up.right")
      })
      .foregroundColor(.gray)
//      Text("Share")
//        .modifier(CaptionStyle())
//        .padding(.trailing, 15)
    }

}
