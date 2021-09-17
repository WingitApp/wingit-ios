
//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//
import SwiftUI

struct ReferButton: View {
    @ObservedObject var referViewModel = ReferViewModel()
  
    var post: Post
    var showLabel: Bool = false

    var body: some View {
        Button(
          action: referViewModel.toggleReferListScreen,
          label: {
            Image(IMAGE_LOGO)
              .resizable()
              .scaledToFit()
              .frame(width: 35, height: 28)
            if self.showLabel {
              Text("Wing")
                .font(.caption)
                .font(.system(size: 15))
            }
        })
        .buttonStyle(PlainButtonStyle())

    }
}
