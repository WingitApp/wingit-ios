//
//  CamVidImage.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct CamVidImage: View {
    var body: some View {
      GeometryReader { proxy in
        
        let size = proxy.size
        
        Image("Pic3")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size.width, height: size.height)
        
      }
          .ignoresSafeArea()
    }
}

struct CamVidImage_Previews: PreviewProvider {
    static var previews: some View {
        CamVidImage()
    }
}
