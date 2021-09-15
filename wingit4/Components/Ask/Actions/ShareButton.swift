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
  var showLabel: Bool = false
  
    var body: some View {
      HStack { 
        Button(
          action: { self.shareButtonViewModel.createDLink(post: post) },
          label: {
            Text(
              Image(systemName: "arrowshape.turn.up.right")
            )
            .fontWeight(.light)
            .modifier(IconButtonStyle())
            if self.showLabel {
              Text("Share")
                .foregroundColor(.black)
                .font(.caption)
                .padding(.trailing, 10)
            }
        })
          .buttonStyle(PlainButtonStyle())
      }
    }

}
