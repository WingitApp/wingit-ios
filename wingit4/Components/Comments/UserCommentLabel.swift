//
//  UserCommentLabel.swift
//  wingit4
//
//  Created by Joshua Lee on 9/21/21.
//

import SwiftUI

struct UserCommentLabel: View {
  var isOPComment: Bool = false
  
    var body: some View {
      if isOPComment {
        Text("OP")
        .fontWeight(.heavy)
        .kerning(1)
        .font(.system(size: 9))
          .foregroundColor(Color.white)
        .padding(
          EdgeInsets(top: 3, leading: 8, bottom: 3, trailing: 8)
        )
          .background(Color.orange.opacity(0.7))
        .cornerRadius(30)
        .clipped()
      }
    }
}
