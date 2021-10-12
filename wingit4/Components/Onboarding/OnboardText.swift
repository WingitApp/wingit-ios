//
//  OnboardTitle.swift
//  wingit4
//
//  Created by Joshua Lee on 10/11/21.
//

import SwiftUI

struct OnboardText: View {
  var screen: BoardingScreen
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      
      Text(screen.title ?? "")
        .font(.title2).bold()
        .foregroundColor(.black)
        .padding(.top,20)
        .fixedSize(horizontal: false, vertical: true)
      
      Text(screen.description ?? "")
        .fontWeight(.semibold)
        .foregroundColor(.black)
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .offset(y: -70)
  }
}
