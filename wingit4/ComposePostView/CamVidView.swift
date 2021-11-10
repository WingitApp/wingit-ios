//
//  CamVidView.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct CamVidView: View {
    var body: some View {
      
      ZStack {
      CamVidImage()
        VStack {
        HStack {
          VStack {
          Image(systemName: "xmark")
            .font(.system(size: 25))
            .foregroundColor(.white)
            .padding(.leading, 10)
            .shadow(
              color: Color.black.opacity(0.3),
              radius: 3, x: 0, y: 0.33
            )
            Spacer()
          }
          Spacer()
          VStack(spacing: 15) {
          Image(systemName: "arrow.triangle.2.circlepath.camera")
          Image(systemName: "bolt.circle")
          Spacer()
        }
          .font(.system(size: 25))
          .foregroundColor(.white)
          .padding(.trailing, 10)
        }
        
          RecordButton()
         
          HStack {
            Image(systemName: "camera")
              .foregroundColor(.white)
            Spacer()
           PostTypeSelection()
            Spacer()
            ZStack {
              BlurredRectangle(width: 25, height: 25, cornerRad: 50)
            Image(systemName: "arrow.forward")
                .foregroundColor(.white)
            }
          } .padding(10)
        }
      }
    }
}

struct CamVid_Previews: PreviewProvider {
    static var previews: some View {
        CamVidView()
    }
}
