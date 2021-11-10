//
//  CaptionVidPic.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct CaptionVidPic: View {
  
  @State var composedMessage: String = ""
  
    var body: some View {
      ZStack {
        Color.black
          .ignoresSafeArea()
        VStack {
          HStack {
          Image(systemName: "chevron.left")
            .foregroundColor(.white)
            .font(.system(size: 25))
            Spacer()
          }.padding(.leading, 10)
          Text("Caption of video or pic")
            .font(.subheadline)
            .foregroundColor(.white)
            .bold()
            .padding()
          CamVidImage()
      HStack(alignment: .center, spacing: 10) {
        PostOrDraftButton()
        PostOrDraftButton(text: "Post!",
                          color: Color.white,
                          background: Color(red: 33 / 255, green: 113 / 255, blue: 150 / 255))
      }.padding()
      }
      }
    }
}

struct CaptionVidPic_Previews: PreviewProvider {
    static var previews: some View {
        CaptionVidPic()
    }
}

