//
//  ActivityIndicatorView.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/15/21.
//

import SwiftUI

struct ActivityIndicatorView<Content>: View where Content: View {
  var message: String = "Sharing..."
  @Binding var isShowing: Bool
  var content: () -> Content

  var body: some View {
    ZStack(alignment: .center) {
      self.content()
        .disabled(self.isShowing)
        .blur(radius: self.isShowing ? 3 : 0)
      VStack {
        ProgressView(message) 
          .progressViewStyle(CircularProgressViewStyle())
      }
      .frame(width: 150, height: 150)
      .background(Color.primary.colorInvert())
      .foregroundColor(.primary)
      .cornerRadius(20)
      .shadow(color: .secondary, radius: 10, x: 1, y: 0)
      .opacity(self.isShowing ? 1 : 0)
    }
  }
}

