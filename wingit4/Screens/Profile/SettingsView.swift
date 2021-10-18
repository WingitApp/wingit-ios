//
//  SettingsView.swift
//  wingit4
//
//  Created by Amy Chun on 10/18/21.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var session: SessionStore
    var body: some View {
      NavigationView{
        Form{
          Section(header: Text("Invite")){
            Label("Invite Friends", systemImage: "person")
          }
          Button(action: {self.session.logout()}){
          Label("Sign Out of Wingit", systemImage: "rectangle.portrait.and.arrow.right")
          }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        
//        Text("Wingit Technologies, Inc.")
//          .multilineTextAlignment(.center)
//          .font(.footnote)
//          .padding(.top, 6)
//          .padding(.bottom, 8)
//          .foregroundColor(Color.secondary)
      }
      .navigationTitle("Settings")
     // .background(Color("background").edgesIgnoringSafeArea(.all))
    }
}

