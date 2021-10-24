//
//  ProfileViewHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 10/22/21.
//

import SwiftUI

struct ProfileViewHeader: View {
  @EnvironmentObject var session: SessionStore
  var isOwnProfile: Bool
  var yOffset: CGFloat
  
  var body: some View {
    VStack {
      HStack {
        Button(action: {}) {
          if isOwnProfile {
            NavigationLink(destination: UsersView()) {
              Image(systemName: "magnifyingglass")
                .imageScale(Image.Scale.medium)
                .foregroundColor(Color.gray)
                .padding(8)
                .background(Color.white)
                .cornerRadius(100)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.borderGray)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0)
            }
          }
        }
        Spacer()
        Button(action: {}) {
          if isOwnProfile {
            NavigationLink(
              destination:
                SettingsView(
                  inviteCode: String(session.currentUser?.inviteCode ?? ""))
            ) {
              Image(systemName: "gearshape.fill")
                .imageScale(Image.Scale.medium)
                .foregroundColor(Color.gray)
                .padding(8)
                .background(Color.white)
                .cornerRadius(100)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.borderGray)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0)
            }
          }
        }
      }
      .padding(.horizontal, 10)
      .padding(.top, 45)
      .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width, alignment: .top)
      .offset(y: yOffset < 0 ? abs(yOffset) : -yOffset)
      Spacer()
    }
    
  }
}
