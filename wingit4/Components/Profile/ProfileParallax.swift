//
//  ProfileParallax.swift
//  wingit4
//
//  Created by Joshua Lee on 10/4/21.
//

import SwiftUI

struct ProfileParallax: View {
    var user: User?
  
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
      return maxHeight + yOffset < minHeight
        ? minHeight
        : maxHeight + yOffset
    }
  
    var body: some View {
      GeometryReader { geometry in
        URLImageView(urlString: user?.profileImageUrl)
            .frame(
              height: self.calculateHeight(
                minHeight:0,
                maxHeight: 230,
                yOffset: geometry.frame(in: .global).origin.y
              )
            )
            .ignoresSafeArea()
            .clipped()
            .offset(
              y: geometry.frame(in: .global).origin.y < 0
                ? abs(geometry.frame(in: .global).origin.y)
                : -geometry.frame(in: .global).origin.y
            )
      }
      .frame(height: 230)
    }
}
