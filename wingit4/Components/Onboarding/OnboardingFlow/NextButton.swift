//
//  NextButton.swift
//  wingit4
//
//  Created by Amy Chun on 10/12/21.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
      HStack{
        Spacer()
      Button(action: {}){
       
          Image(systemName: "chevron.right.circle.fill")

      }.padding()
      }
    }
}


struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}
