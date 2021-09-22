//
//  NotificationUserAvatar.swift
//  wingit4
//
//  Created by Joshua Lee on 9/14/21.
//

import SwiftUI

struct NotificationUserAvatar: View {

  var imageUrl: String = DEFAULT_PROFILE_AVATAR
  var type: String
  
    func getIconByType() -> String {
      switch type {
      // activity
      case "comment":
        return "bubble.right.fill"
      case "follow":
        return "person.2.fill"
      case "like":
        return "heart.fill"
      case "likeAsk":
        return "heart.fill"
      case "connectRequest":
        return "link"
      case "connectRequestAccepted":
          return "checkmark"
      case "referred":
          return "heart.text.square.fill"
      // referral
      case "accepted":
        return "checkmark"
      case "closed":
        return "xmark"
      case "pending":
        return "heart.text.square.fill"
      case "winged":
        return "paperplane.fill"
      default:
          return "bolt.fill"
      }
    }
  
  func getBackgroundByType() -> Color {
    switch type {
    // activity
    case "comment":
      return Color(.systemTeal)
    case "follow":
      return Color(.systemIndigo)
    case "like":
      return Color(.systemRed)
    case "likeAsk":
      return Color(.systemRed)
    case "connectRequest":
      return Color("Color1")
    case "connectRequestAccepted":
      return Color("Color1")
    case "referred":
      return Color(.systemBlue)
    // referral
    case "accepted":
      return Color("Color1")
    case "closed":
      return Color(.lightGray)
    case "pending":
      return Color(.systemBlue)
    case "winged":
      return Color.wingitBlue
    default:
      return Color(.systemTeal)
    }
  }
  
    
    var body: some View {
      ZStack {
        URLImageView(urlString: imageUrl)
          .clipShape(Circle())
          .frame(width: 50, height: 50)
          .overlay(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.gray, lineWidth: 1)
          )
          .zIndex(0)
          Image(systemName: getIconByType())
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(5)
            .background(
              LinearGradient(
                gradient: Gradient(
                  colors: [getBackgroundByType().lighter(by: 10), getBackgroundByType()]),
                  startPoint: .top,
                  endPoint: .bottom
                )
            )
            .cornerRadius(100)
            .offset(x: 18, y: 13)
            .frame(width: 20, height: 20)
            .shadow(
              color: Color.black.opacity(0.3),
              radius: 1, x: 0, y: -1
            )
            .zIndex(1)

            
      }
    }
}
