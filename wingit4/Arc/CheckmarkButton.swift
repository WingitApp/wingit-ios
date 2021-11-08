//
//  CheckmarkButton.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct CheckmarkButton: View {
    var body: some View {
      Button(action: {}){
        Image(systemName: "circle")
      }
    }
}

struct CheckmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkButton()
    }
}
