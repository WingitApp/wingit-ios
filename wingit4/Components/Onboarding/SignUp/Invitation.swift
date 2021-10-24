//
//  Invitation.swift
//  wingit4
//
//  Created by Daniel Yee on 10/22/21.
//

import SwiftUI

struct Invitation: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
  var inviter: User?
  
    var body: some View {
      VStack(alignment: .center, spacing: 10){
      Text("Invite from \(inviter?.displayName ?? "your friend") to join Wingit")
        .font(.caption)
        
      URLImageView(urlString: inviter?.profileImageUrl)
          .frame(width: 150, height: 150)
          .cornerRadius(100)
          .padding(5)
        
      HStack(spacing: 10) {
        AcceptInvitationButton(inviter: inviter ?? USER_PROFILE_DEFAULT_PLACEHOLDER)
      }
      }
    }
}
