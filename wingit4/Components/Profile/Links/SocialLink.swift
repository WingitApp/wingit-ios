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
  
  func openLink() -> Void {
    if let url = URL(string: "https://www.hackingwithswift.com") {
        UIApplication.shared.open(url)
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
              .blur(radius: link == "" ? 0.2 : 0)
          Text(
            Image(systemName: "plus")
          )
            .bold()
            .font(.system(size: 8))
            .foregroundColor(Color.wingitBlue)
            .padding(3)
            .background(
              LinearGradient(
                gradient: Gradient(
                  colors: [Color.lightGray.lighter(by: 3), Color.lightGray]),
                  startPoint: .top,
                  endPoint: .bottom
                )
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.borderGray, lineWidth: 1)
                )
            )
            .cornerRadius(100)
            .offset(x: 13, y: -14)
//            .shadow(
//              color: Color.black.opacity(0.3),
//              radius: 1, x: 0, y: -1
//            )
            .zIndex(1)

        }
      }
      .buttonStyle(PlainButtonStyle())

    }
}

