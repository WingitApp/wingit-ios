//
//  CircleLoader.swift
//  wingit4
//
//  Created by Joshua Lee on 8/26/21.
//

import SwiftUI

struct CircleLoader: View {
  @State private var isLoading = true
  
    var body: some View {
      ZStack {
       
                  Circle()
                      .stroke(Color(.systemGray5), lineWidth: 14)
                      .frame(width: 40, height: 40)
       
                  Circle()
                      .trim(from: 0, to: 0.2)
                      .stroke(Color.green, lineWidth: 7)
                      .frame(width: 40, height: 40)
                      .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                      .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                      .onAppear() {
                          self.isLoading = true
                  }
              }
    }
}

