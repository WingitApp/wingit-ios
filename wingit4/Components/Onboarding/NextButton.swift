//
//  NextButton.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
    
      VStack{
      ZStack{
        Image(systemName: "circle")
          .font(.system(size: 45))
          .foregroundColor(.wingitBlue)
          .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0)
       Image(systemName: "chevron.right.circle.fill").padding()
            .font(.system(size: 45))
            .foregroundColor(.wingitBlue)
   
      }
      }.padding(.vertical, 25).padding(.horizontal, 15)
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}
