//
//  SocialLink.swift
//  wingit4
//
//  Created by Joshua Lee on 10/2/21.
//

import SwiftUI
import SPAlert

struct SocialLink: View {
  @EnvironmentObject var session: SessionStore
  
  var name: String
  var bgColor: Color
  var link: String = ""
  var isEditable: Bool
  
  func onTap() {
    if link.isEmpty || isEditable {
      addLink()
    } else if !link.isEmpty {
      openLink()
    } else {
      return
    }
  }
  
  func openLink() -> Void {
    
    if let url = URL(string: link) {
        UIApplication.shared.open(url)
    }
  }
  
  func userDidEdit(_ url: String) -> Bool {
    return !url.isEmpty && url.trimmingCharacters(in: .whitespacesAndNewlines) != link.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func validHttpsLink(_ url: String) -> String {
      var comps = URLComponents(string: url)!
      comps.scheme = "https"
      let https = comps.string!
      return https
  }
  
  func addLink() -> Void {
    let properName = name.capitalized
    alertView(
      msg: "Add \(properName) Link",
      placeholder: link
    ) { (url) in
      if url.isEmpty {
        let alertView = SPAlertView( title: "", message: "Link cannot be empty.", preset: SPAlertIconPreset.error)
          alertView.present(duration: 2)
          return
      }
      
      if !url.contains(name) {
        let alertView = SPAlertView( title: "", message: "Link must be from \(properName)", preset: SPAlertIconPreset.error)
          alertView.present(duration: 2)
          return
      }
      
      
      if userDidEdit(url) {
        let httpsLink = validHttpsLink(url)
        Api.User.addLink(
          type: name,
          link: httpsLink
        ) { newLink in
          session.currentUser![name] = newLink
          let alertView = SPAlertView( title: "Success", message: "Link updated!", preset: SPAlertIconPreset.done)
          alertView.present(duration: 2)
        }
      }
    }
  }
  
  func primaryColor() -> Color {
    switch(name) {
      case "facebook":
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

        Button(action: onTap) {
          ZStack {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .padding(10)
                .clipShape(Circle())
                .background(bgColor)
                .cornerRadius(100)
            if isEditable && link.isEmpty {
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
        .disabled(!isEditable && link == "")
    }
}

