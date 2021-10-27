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
  @ObservedObject var emailVerificationViewModel = EmailVerificationViewModel()
  var inviteCode: String
  
  func onTap(){
    emailVerificationViewModel.sendEmailVerification()
    emailVerificationViewModel.verifyEmail = true
  }
  
  var body: some View {
    VStack{
      Form {
        
        if !emailVerificationViewModel.emailIsVerified {
        Section(header: Text("Email Verification")) {
          Button(action: onTap )
          {
            Label(emailVerificationViewModel.verifyEmail ? "Email verification sent" : "Tap to resend email verification", systemImage: "envelope.fill")
          }
        }
        }
        
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
    .onAppear{emailVerificationViewModel.checkIfEmailIsVerified()}
    
  }
}
