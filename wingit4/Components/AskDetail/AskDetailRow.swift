//
//  AskDetailRow.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailRow: View {
  @Binding var post: Post

    var body: some View {
      VStack(alignment: .leading) {
        Text("Wingers")
          .font(.headline)
          .padding(.bottom, 5)
        HStack {
          Circle()
            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.orange)
          
          Circle()
            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.gray)
            .padding(.leading, -15)
          Circle()
            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.yellow)
            .padding(.leading, -15)
          Circle()
            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.red)
            .padding(.leading, -15)
          Circle()
            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(.blue)
            .padding(.leading, -15)
          Text("+344")
            .font(.caption)
        }
      }
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15)
      )

    }
}
