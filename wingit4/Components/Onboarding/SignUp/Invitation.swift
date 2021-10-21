//
//  Invitation.swift
//  wingit4
//
//  Created by Daniel Yee on 10/18/21.
//

import SwiftUI

struct Invitation: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
  var inviter: User?
  
    var body: some View {
      URLImageView(urlString: inviter?.profileImageUrl)
        .frame(width: 120, height: 120)
        .cornerRadius(100)
        .padding(5)
      HStack(spacing: 10) {
        AcceptInvitationButton(inviter: inviter ?? USER_PROFILE_DEFAULT_PLACEHOLDER)
      }
    }
}
