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
          Section(header: Text("Invite"),
                  footer: Text("Referral Code: \(inviteCode)")) {
            Button(action: { inviteFriendsViewModel.shareLink(currentUser: session.currentUser) }) {
              Label("Invite Friends", systemImage: "figure.wave")
            }
          }
//          Section(header: Text("Invite")){
//            NavigationLink (destination: InviteFriendsView(inviteCode: String(session.currentUser?.id?.prefix(6) ?? ""))) {
//              Label("Invite Friends", systemImage: "person")
//            }
//          }
          Button(action: {self.session.logout()}) {
          Label("Sign Out of Wingit", systemImage: "hand.wave.fill")
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

//  Section(header: Text("Invite"),
//          footer: Text("Referral Code \(session.currentUser?.id?.prefix(6))")
//  {
//    Button(action: { inviteFriendsViewModel.shareLink(currentUser: session.currentUser) }){
//      Label("Invite Friends", systemImage: "person")
//    }
//  }
