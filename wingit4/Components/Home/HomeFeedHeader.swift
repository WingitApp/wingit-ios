//
//  HomeFeedHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 9/7/21.
//

import SwiftUI

struct HomeFeedHeader: View {
    var body: some View {
      HStack(alignment: .center) {
        Image(systemName: "rectangle.grid.1x2.fill")
          .font(.system(size: 15))
          .foregroundColor(.gray)
        Spacer()
        Circle()
          .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(.gray)
        Circle()
          .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(Color.charcoal)
        Circle()
          .frame(width: 8, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .foregroundColor(.gray)
        Spacer()
        Image(systemName: "line.horizontal.3.decrease.circle")
          .font(.system(size: 20))
          .foregroundColor(.gray)
      }
      .padding(
        EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15)
      )
    }
}

struct HomeFeedHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedHeader()
    }
}
