//
//  ReferalComment.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct ReferralComment: View {

    
    var body: some View {
      HStack(alignment: .center) {
        Circle()
          .frame(width: 23, height: 23, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(Color(.systemTeal))
        Circle()
          .frame(width: 23, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(.pink)
          .padding(.leading, -15)
        Group {
          Text("Daniel Yee ").bold() +
          Text("invited ") +
          Text("Joshua Lee ").bold() +
          Text("to help.")
        }.font(.caption)
        Spacer()
      }
      .padding(.leading, 10)
      Divider() //END
    }
}

