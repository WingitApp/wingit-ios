//
//  BlurView.swift
//  wingit4
//
//  Created by Joshua Lee on 9/25/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIVisualEffectView {
    let view = UIVisualEffectView(
      effect: UIBlurEffect(style: .systemMaterialLight)
    )
    
    return view
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    
  }
}
