//
//  Title.swift
//  wingit4
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct Title: View {
  
  var title: String = "hello"
  
    var body: some View {
      VStack(alignment: .leading, spacing: 3) {

      HStack(spacing: 3) {
        
        Text(title)
        .bold()
        .font(.title3)
        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundColor(.gray)
      }
        AvatarPicName()
      }.padding(.horizontal)
    }
}


struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
    }
}
