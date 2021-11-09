//
//  TextPreview.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextUpdateView: View {
  
  var width: CGFloat = 160
  var height: CGFloat = 125
  
    var body: some View {
      
      VStack {
        HStack(alignment: .top) {
        Text("Page Title")
          .bold()
          .font(.title3)
          .padding(.vertical, 3)
          Spacer()
        }
        Text("Blah blah blah. Preview of the text for updates. Please please help? this is my update. etc. etc.fdjkaslf;djksal;fjdkl;asjfkdl;sajjfkdls;ajfdkls;ajfkdl;safjdkla;fjkdl;sajfkdl;sjakfld;saf fal lalalallalal")
          .font(.caption)
      }
      .frame(width: width, height: height)
      .background(Color.white)
    
      
    }
}


