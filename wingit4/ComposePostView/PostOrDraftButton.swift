//
//  PostOrDraftButton.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct PostOrDraftButton: View {
  
  var text: String = "Save as Draft"
  var color: Color = Color(red: 33 / 255, green: 113 / 255, blue: 150 / 255)
  var background: Color = Color.white
  
    var body: some View {
      
      HStack {
        Text(text)
          .font(.caption)
          .bold()
          .foregroundColor(color)
      }
      .cornerRadius(10)
      .frame(width: 150, height: 45)
      .background(background)
     
    }
}

struct SaveDraftButton_Previews: PreviewProvider {
    static var previews: some View {
      PostOrDraftButton()
    }
}
