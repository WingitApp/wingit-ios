//
//  CircleLoader.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//

import SwiftUI

struct CircleLoader: View {
  @State private var isLoading = false
  var size: CGFloat = 15
  
    var body: some View {
        ZStack {
          Circle()
              .stroke(Color.white, lineWidth: 4)
              .frame(width: size, height: size)
              .overlay(
                Circle()
                  .stroke(Color(.systemGray5), lineWidth: 1)
              )

          Circle()
              .trim(from: 0, to: 0.2)
              .stroke(Color("Color"), lineWidth: 2)
              .frame(width: size, height: size)
              .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
              .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
              .onAppear() {
                  self.isLoading = true
              }
      }
      
    }
}
