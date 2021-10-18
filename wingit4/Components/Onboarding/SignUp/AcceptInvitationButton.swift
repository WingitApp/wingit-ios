//
//  AcceptInvitationButton.swift
//  wingit4
//
//  Created by Daniel Yee on 10/18/21.
//

import SwiftUI

struct AcceptInvitationButton: View {
  @EnvironmentObject var signupViewModel: SignupViewModel
  @State var userHasAccepted: Bool = false
  var inviter: User
  
  var body: some View {
      Button(action: {
        Haptic.impact(type: "soft")
        signupViewModel.acceptInvitation()
        logToAmplitude(event: .acceptInvitation, properties: [.senderId: inviter.id])
      },
             label: {
              HStack(alignment: .center) {
                Image(systemName: "checkmark.circle")
                  .foregroundColor(.white)
                Text("Accept Invitation")
                  .fontWeight(.semibold)
              }
              .foregroundColor(.white)
              .padding(.vertical, 10)
              .frame(width: (UIScreen.main.bounds.width) - 20)
              .background(Color.wingitBlue)
              .cornerRadius(5)
              .overlay(
                RoundedRectangle(cornerRadius: 5).stroke(Color.wingitBlue,
                lineWidth: 1)
              )
      }).disabled(self.userHasAccepted)
  }
}
