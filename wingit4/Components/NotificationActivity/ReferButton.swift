
//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//
import SwiftUI

struct ReferButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @EnvironmentObject var askCardViewModel: AskCardViewModel

    @Binding var post: Post
    var showLabel: Bool = false

    var body: some View {
        Button(action: {
            Haptic.impact(type: "soft")
            referViewModel.isReferListOpen.toggle()
        },
        label: {
          Text(Image(systemName: "paperplane"))
            .fontWeight(.light)
            .modifier(IconButtonStyle())
          if self.askCardViewModel.wingers.count > 0 {
            Text("\(askCardViewModel.wingers.count.formatUsingAbbrevation())")
              .font(.caption)
              .foregroundColor(Color.wingitBlue)
          }
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
