//
//  AskDetailHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI
import URLImage


struct AskDetailHeader: View {
  @Binding var post: Post?
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    var body: some View {
      HStack {
        Button(action: {
          Haptic.impact(type: "soft")
          self.presentationMode.wrappedValue.dismiss()
        }) {
          HStack(alignment: .center) {
            Image(systemName: "chevron.left.circle.fill")
              .imageScale(.large)
            Text("Back")
//              .font(.caption)
              .font(.system(size: 16))
          }
          .foregroundColor(.wingitBlue)
   
        }
        Spacer()
        CommentButton(
          isTapDisabled: true
        )
        ReferButton()
        AskMenu(
          isHorizontal: true
        )
      }
      .padding(
        EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      )
    }
}
