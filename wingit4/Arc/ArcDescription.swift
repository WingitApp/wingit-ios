//
//  ArcDescription.swift
//  wingit4
//
//  Created by Amy Chun on 11/7/21.
//

import SwiftUI

struct ArcDescription: View {
  
  var description: String = "Description of the Project. blah blah blah blah I love the Lord God Almighty maker of heaven and earth. Today is the day you have made I will rejoice and be glad in it."
  
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
