//
//  BumpersRow.swift
//  wingit4
//
//  Created by Joshua Lee on 9/18/21.
//

import SwiftUI

struct BumpersRow: View {
  
  @Binding var bumpers: [User]
  var title: String?
  var emptyMessage: String?
  
  static let DISPLAY_LIMIT = 5
  
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
          Text(title ?? "Wingers")
            .font(.headline)
            .padding(.top, 10)
            .padding(.bottom, 10)
          HStack {
            ForEach(Array(bumpers.prefix(BumpersRow.DISPLAY_LIMIT).enumerated()), id: \.element) { index, winger in
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

            BumpersTextDescription.getFormattedString(
              bumpers: bumpers,
              limit: BumpersRow.DISPLAY_LIMIT,
              emptyMessage: emptyMessage
            )
            .font(.caption)
        }
      }
      .padding(
        EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
      )
    }
}


class BumpersTextDescription {
  
  static func getFormattedCount(
    users: [User],
    limit: Int,
    emptyMessage: String?
  ) -> Text {
    

    switch users.count {
      case 0:
        return Text(emptyMessage ?? "")
      case 1:
        return Text(users[0].displayName!.capitalized).bold()
      case 2:
        return (
          Text(users[0].displayName!.capitalized).bold() +
          Text(" & ").bold() +
          Text(users[1].displayName!.capitalized).bold()
        )
      default:
        var names: [String] = []
        
        if users.count <= limit {
          
          for index in users.indices {
            let user = users[index]
            
            if (index == users.count - 2) {
              names.append(user.displayName!.capitalized + ", and ")
            } else if (index == users.count - 1) {
              names.append(user.displayName!.capitalized)
            } else {
              names.append(user.displayName!.capitalized + ", ")
            }
          }
          
          return Text(names.joined(separator: "")).bold()
          
        } else {
          let remainder = users.count - limit
          
          for index in users.prefix(limit).indices {
            let user = users[index]
            
            if (index == users.count - 1) {
              names.append(user.displayName!.capitalized)
            } else {
              names.append(user.displayName!.capitalized + ", ")
            }
          }
          
          return Text(names.joined(separator: "")).bold() + Text("and \(remainder) \(remainder > 1 ? "others" : "other")").bold()
        }
    }
  }
  
  static func getFormattedString(
    bumpers: [User],
    limit: Int,
    emptyMessage: String?
  ) -> Text {
    var names: [String] = []
    if bumpers.count == 0 {
      return Text(emptyMessage ?? "Be the first to wing this request!")
    } else if bumpers.count == 1 {
      return (
        Text(bumpers[0].displayName!.capitalized).bold() +
        Text(" has winged this request.")
      )
    } else if bumpers.count == 2 {
      return (
        Text(bumpers[0].displayName!.capitalized).bold() +
        Text(" & ").bold() +
        Text(bumpers[1].displayName!.capitalized).bold() +
        Text(" have winged this request.")
      )
    } else if bumpers.count <= limit {
      
      for index in bumpers.indices {
        let bumper = bumpers[index]
        
        if (index == bumpers.count - 2) {
          names.append(bumper.displayName!.capitalized + ", and ")
        } else if (index == bumpers.count - 1) {
          names.append(bumper.displayName!.capitalized)
        } else {
          names.append(bumper.displayName!.capitalized + ", ")
        }
      }
      
      return (
        Text(names.joined(separator: "")).bold() +
        Text(" have winged this request.")
      )
    } else if bumpers.count > limit {
      for index in bumpers.prefix(limit).indices {
        let bumper = bumpers[index]
          names.append(bumper.displayName!.capitalized)
      }
      
      let remainder = bumpers.count - limit
      
      return (
        Text(names.joined(separator: ", ")).bold() +
        Text(" and ") +
        Text("\(remainder) ").bold() +
        Text("\(remainder > 1 ? "others" : "other")").bold() +
        Text(" have winged this request.")
      )
    }
    
    return Text("")
  }
}

