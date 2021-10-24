//
//  SettingsView.swift
//  wingit4
//
//  Created by Amy Chun on 10/18/21.
//

import SwiftUI

struct SettingsView: View {
  @EnvironmentObject var session: SessionStore
  @ObservedObject var inviteFriendsViewModel = InviteFriendsViewModel()
  var inviteCode: String
  
  var body: some View {
    VStack{
      Form{
        Section(
          header: Text("Invite"),
          footer: HStack{
            Spacer()
            Text("Referral Code: ")
              .fontWeight(.semibold)
            +
            Text(String(inviteCode))
              .bold()
              .foregroundColor(Color.wingitBlue)
          }
        )
        {
          Button(action: { inviteFriendsViewModel.shareLink(currentUser: session.currentUser) }) {
            Label("Invite Friends", systemImage: "figure.wave")
          }
        }
        Section(header: Text("Sign Out")){
          Button(action: {self.session.logout()}) {
            Label("Sign Out of Wingit", systemImage: "hand.wave.fill")
          }
        }
        
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        
      }
      .navigationTitle("Settings")
      // .background(Color("background").edgesIgnoringSafeArea(.all))
    }
    
  }
}
