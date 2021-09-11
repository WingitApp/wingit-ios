//
//  CloseButton.swift
//  wingit4
//
//  Created by Joshua Lee on 9/11/21.
//

import SwiftUI

struct CloseButton: View {
  var onTap: () -> Void
  
  
    var body: some View {
      Image(systemName: "xmark")
        .foregroundColor(Color.gray)
        .padding(15)
        .onTapGesture(perform: onTap)
    }
}
