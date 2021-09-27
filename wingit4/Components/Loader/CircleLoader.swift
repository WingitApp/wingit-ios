//
//  CircleLoader.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//

import SwiftUI

struct CircleLoader: View {
  @State private var isLoading = false
  
    var body: some View {
        ZStack {
          Circle()
              .stroke(Color(.systemGray5), lineWidth: 4)
              .frame(width: 15, height: 15)

          Circle()
              .trim(from: 0, to: 0.2)
              .stroke(Color.wingitBlue, lineWidth: 2)
              .frame(width: 15, height: 15)
              .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
              .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
              .onAppear() {
                  self.isLoading = true
              }
      }
      
    }
}
