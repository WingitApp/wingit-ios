
//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//
import SwiftUI

struct ReferButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post
    var showLabel: Bool = false
  //  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
//    @EnvironmentObject var session: SessionStore
    var body: some View {
        Button(action: {
            referViewModel.isReferListOpen.toggle()
        },
        label: {
          Image(IMAGE_LOGO)
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 28)
          if self.showLabel {
            Text("Wing")
              .font(.caption)
              .font(.system(size: 15))
//              .padding(.leading, 10)
          }
        })
        .buttonStyle(PlainButtonStyle())

    }
}
