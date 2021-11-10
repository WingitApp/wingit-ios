//
//  RecordButton.swift
//  wingit4
//
//  Created by Amy Chun on 11/10/21.
//

import SwiftUI

struct RecordButton: View {
    var body: some View {
      
        ZStack {
        Image(systemName: "circle.fill")
          .font(.system(size: 64))
          .foregroundColor(Color(red: 55 / 255, green: 178 / 255, blue: 171 / 255))
        Image(systemName: "circle")
          .font(.system(size: 80))
          .foregroundColor(Color(red: 55 / 255, green: 178 / 255, blue: 171 / 255, opacity: 0.7))
        }
      
    }
}

struct RecordingButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton()
    }
}
