//
//  ParallaxImage.swift
//  wingit4
//
//  Created by Joshua Lee on 9/9/21.
//

import SwiftUI
import URLImage


struct ParallaxImage: View {
    
  var imageURL: String
  var height: CGFloat
  
  func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
        // If scrolling up, yOffset will be a negative number
        if maxHeight + yOffset < minHeight {
            // SCROLLING UP
            // Never go smaller than our minimum height
            return minHeight
        }
        
        // SCROLLING DOWN
        return maxHeight + yOffset
    }
  
  var body: some View {
    VStack {
      GeometryReader { geometry in
        URLImage(
            URL(string: imageURL)!,
            content: {
              $0.image
                .resizable()
                .scaledToFill()
                .frame(height: self.calculateHeight(
                    minHeight: 0,
                    maxHeight: height,
                    yOffset: geometry.frame(in: .global).origin.y)
                )
                .clipped()
                .offset(
                  y: geometry.frame(in: .global).origin.y < 0 // Is it going up?
                      ? abs(geometry.frame(in: .global).origin.y) // Push it down!
                      : -geometry.frame(in: .global).origin.y
                ) // Push it up!
          })
      }
    }
    .frame(height: height)
      
  }
}

