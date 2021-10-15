//
//  NextButton.swift
//  wingit4
//
//  Created by Amy Chun on 10/13/21.
//

import SwiftUI

struct NextButton: View {
    var body: some View {
    
      
       Image(systemName: "chevron.right.circle.fill").padding()
            .font(.system(size: 45))
            .foregroundColor(.wingitBlue)
        
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton()
    }
}
