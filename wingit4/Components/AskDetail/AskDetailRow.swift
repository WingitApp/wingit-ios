//
//  AskDetailRow.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailRow: View {
  @EnvironmentObject var askCardViewModel: AskCardViewModel

  @Binding var post: Post
  
  func getColorByIndex(index: Int) -> Color {
    return Color.wingitBlue
//    let order = index % 5
//
//    switch(order) {
//      case 0:
//        return Color.orange
//      case 1:
//        return Color.gray
//      case 2:
//        return Color.yellow
//      case 3:
//        return Color.red
//      case 4:
//        return Color.blue
//      default:
//        return Color(.systemTeal)
//    }
  }
  
  func getPaddingByIndex(index: Int) -> CGFloat {
    if index > 0 {
      return -15
    }
    return 0
  }

    var body: some View {
      VStack(alignment: .leading) {
        if (askCardViewModel.wingers.count > 0) {
          Text("Wingers")
            .font(.headline)
            .padding(.bottom, 5)
        }
        HStack {
          ForEach(Array(askCardViewModel.wingers.enumerated()), id: \.element) { index, winger in
            UserAvatar(
              user: winger,
              height: 30,
              width: 30
            )
            .overlay(
              RoundedRectangle(cornerRadius: 100)
                .stroke(getColorByIndex(index: index), lineWidth: 1)
            )
            .padding(.leading, getPaddingByIndex(index: index))
          }
//          Circle()
//            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .foregroundColor(.orange)
//
//          Circle()
//            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .foregroundColor(.gray)
//            .padding(.leading, -15)
//          Circle()
//            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .foregroundColor(.yellow)
//            .padding(.leading, -15)
//          Circle()
//            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .foregroundColor(.red)
//            .padding(.leading, -15)
//          Circle()
//            .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .foregroundColor(.blue)
//            .padding(.leading, -15)
//          Text("+344")
//            .font(.caption)
        }
      }
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15)
      )

    }
}
