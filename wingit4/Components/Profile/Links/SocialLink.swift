//
//  SocialLink.swift
//  wingit4
//
//  Created by Joshua Lee on 10/2/21.
//

import SwiftUI

struct SocialLink: View {
  var name: String
  var bgColor: Color
  var link: String = ""
  var isEditable: Bool
  
  func openLink() -> Void {
    if let url = URL(string: "https://www.hackingwithswift.com") {
        UIApplication.shared.open(url)
    }
  }
  
  func primaryColor() -> Color {
    switch(name) {
      case "fb":
        return Color.fbBlue
      case "instagram":
        return Color.igPurple
      case "tiktok":
        return Color.tiktokTeal
      case "twitter":
        return Color.twitterBlue
      case "reddit":
        return Color.redditRed
      case "linkedin":
        return Color.linkedinBlue
      case "spotify":
        return Color.spotifyGreen
      
      default:
        return Color.wingitBlue.opacity(0.3)
    }
  }
  
  
    var body: some View {

        Button(action: openLink) {
          ZStack {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding(10)
                .clipShape(Circle())
                .background(bgColor)
                .cornerRadius(100)
            if isEditable {
              Text(Image(systemName: "plus"))
                 .font(.system(size: 8.5))
                 .fontWeight(.heavy)
                 .foregroundColor(primaryColor())
                 .padding(2.5)
                 .background(
                   LinearGradient(
                     gradient: Gradient(
                       colors: [bgColor, bgColor]
                     ),
                       startPoint: .top,
                       endPoint: .bottom
                     )
                 )
                 .cornerRadius(100)
                 .offset(x: 12, y: -11.5)
            }
          }
        }
        .buttonStyle(PlainButtonStyle())

    }
}

