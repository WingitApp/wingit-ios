//
//  InviteFriendsView.swift
//  wingit4
//
//  Created by Daniel Yee on 10/19/21.
//

import Foundation
import SwiftUI

struct InviteFriendsView: View {
  var inviteCode: String
  @EnvironmentObject var session: SessionStore
  @ObservedObject var inviteFriendsViewModel = InviteFriendsViewModel()
  
  var body: some View {
    Text("Referral Code")
    HStack {
      Text(inviteCode)
        .fontWeight(.heavy)
        .kerning(1)
        .font(.system(size: 24))
        .foregroundColor(Color.black)
        .padding(
          EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        )
        .background(Color.uilightGreen)
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
                  .stroke(Color.uilightGreen.darker(by: 4), lineWidth: 1))
        .clipped()
        .shadow(color: Color.uilightGreen.darker(by: 4).opacity(0.5), radius: 2, x: 0, y: 0)
      Spacer()
      Button(action: { inviteFriendsViewModel.shareLink(currentUser: session.currentUser) }) {
      Image(systemName: "square.and.arrow.up.fill")
      }
    }
  }
}
