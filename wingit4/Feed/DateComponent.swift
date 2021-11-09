//
//  DateComponent.swift
//  wingit4
//
//  Created by Amy Chun on 11/4/21.
//

import SwiftUI

struct DateComponent: View {
  
  var date: String = "March 3, 0000"
    var body: some View {
      Text(date)
        .font(.caption)
        .bold()
       
    }
}
