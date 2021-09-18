//
//  AskDetailRow.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct WingersRow: View {
  @Binding var wingers: [User]
  
  static let WINGER_DISPLAY_LIMIT = 5
  
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
    return index > 0 ? -15 : 0
  }
  
 
    var body: some View {
      VStack(alignment: .leading) {
          Text("Wingers")
            .font(.headline)
            .padding(.top, 10)
            .padding(.bottom, 10)
          HStack {
            ForEach(Array(wingers.prefix(WingersRow.WINGER_DISPLAY_LIMIT).enumerated()), id: \.element) { index, winger in
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

            WingerTextDescription.getFormattedString(
              wingers: wingers,
              limit: WingersRow.WINGER_DISPLAY_LIMIT
            )
            .font(.caption)
        }
      }
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
      )
    }
}


class WingerTextDescription {
  
  static func getFormattedString(wingers: [User], limit: Int) -> Text {
    var names: [String] = []
    if wingers.count == 0 {
      return Text("Be the first to wing this request!")
      
    } else if wingers.count == 1 {
      print("wingers[0]:",wingers[0])
      return (
        Text(wingers[0].displayName!.capitalized).bold() +
        Text(" has winged this request.")
      )
    } else if wingers.count == 2 {
      return (
        Text(wingers[0].displayName!.capitalized).bold() +
        Text(" & ").bold() +
        Text(wingers[1].displayName!.capitalized).bold() +
        Text(" have winged this request.")
      )
    } else if wingers.count <= limit {
      
      for index in wingers.indices {
        let winger = wingers[index]
        
        if (index == wingers.count - 2) {
          names.append(winger.displayName!.capitalized + ", and ")
        } else if (index == wingers.count - 1) {
          names.append(winger.displayName!.capitalized)
        } else {
          names.append(winger.displayName!.capitalized + ", ")
        }
      }
      
      return (
        Text(names.joined(separator: "")).bold() +
        Text(" have winged this request.")
      )
    } else if wingers.count > limit {
      for index in wingers.prefix(limit).indices {
        let winger = wingers[index]
          names.append(winger.displayName!.capitalized)
      }
      
      let remainder = wingers.count - limit
        
      return (
        Text(names.joined(separator: ", ")).bold() +
        Text("and ") +
        Text("\(remainder) ").bold() +
        Text("\(remainder > 1 ? "others" : "other")").bold() +
        Text(" have winged this request.")
      )
    }
    
    return Text("")
  }
}

