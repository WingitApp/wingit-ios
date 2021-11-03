//
//  PageViewButton.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct PageViewButton: View {
  
  var icon: String = "suit.heart"
  var function: (() -> Void)?
  
  func onTapButton() {
    self.function!()
  }
  
    var body: some View {
      
      Button(action: onTapButton){
      Image(systemName: icon)
        .font(.system(size: 35))
        .foregroundColor(.white)
      }
      
    }
}

struct PageViewButton_Previews: PreviewProvider {
    static var previews: some View {
        PageViewButton()
    }
}
