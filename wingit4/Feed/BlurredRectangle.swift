//
//  BlurredRectangle.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct BlurredRectangle: View {
  
  var width: CGFloat = 175
  var height: CGFloat = 70
  var cornerRad: CGFloat = 10
  
    var body: some View {
   
      Text("")
        .frame(width: width, height: height)
        .background(Color.black.opacity(0.3))
        .background(Blur(style:.systemUltraThinMaterial))
        .cornerRadius(cornerRad)

    }
}

struct BlurredRectangle_Previews: PreviewProvider {
    static var previews: some View {
        BlurredRectangle()
    }
}
