//
//  TextPreview.swift
//  wingit4
//
//  Created by Amy Chun on 11/8/21.
//

import SwiftUI

struct TextPreview: View {
    var body: some View {
      
      VStack {
        HStack(alignment: .top) {
        Text("Page Title")
          .bold()
          .font(.title3)
          .padding(.vertical, 3)
          Spacer()
        }
        Text("Blah blah blah. Preview of the text for updates. Please please help? this is my update. etc. etc.fdjkaslf;djksal;fjdkl;asjfkdl;sajjfkdls;ajfdkls;ajfkdl;sa")
          .font(.caption)
      }
      .frame(width: 160, height: 125)
      .padding(10)
      .background(Color.white)
      .cornerRadius(10)
      
    }
}

struct TextPrview_Previews: PreviewProvider {
    static var previews: some View {
        TextPreviewCard()
    }
}
