//
//  ArcDescription.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcDescription: View {
  
  var description: String = "Description of the Project. blah blah blah blah Today is amazing. live laugh love. what is the meaning of life? 4d, 3d, 5d? 11d? "
  
    var body: some View {
        Text(description)
        .fontWeight(.medium)
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
    }
}

struct ArcDescription_Previews: PreviewProvider {
    static var previews: some View {
        ArcDescription()
    }
}
