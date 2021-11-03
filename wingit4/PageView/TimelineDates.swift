//
//  TimelineDates.swift
//  Wingit2.0
//
//  Created by Amy Chun on 11/1/21.
//

import SwiftUI

struct TimelineDates: View {
  
  var date: String = "2/2"
  
    var body: some View {
      

      VStack(spacing: 3) {
      Text(date)
          .foregroundColor(.gray)
          .font(.caption)
          .bold()
        
      HStack{
      Divider()
      }
//      .frame(height: 100)
      }
     
      
    }
}

struct TimelineDates_Previews: PreviewProvider {
    static var previews: some View {
        TimelineDates()
    }
}
