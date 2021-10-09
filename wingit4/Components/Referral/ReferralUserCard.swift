//
//  ReferralUserCard.swift
//  wingit4
//
//  Created by Joshua Lee on 9/16/21.
//

import SwiftUI

struct ReferralUserCard: View {
    @EnvironmentObject var referViewModel: ReferViewModel

    var user: User
    var isChecked: Bool = false
  
    func onTapGesture() {
      
      if  !referViewModel.userBumps.filter({ $0.id == user.id }).isEmpty {
        // we don't need to add users who are already bumped
        return
      }
      self.referViewModel.handleUserSelect(user: user)
    }
  
  @State var isTapped: Bool = false
  
  func onUserAvatarTap() {
    Haptic.impact(type: "soft")
    isTapped = true
  }
    
    var body: some View {
      
        
        HStack(spacing: 0) {
          UserRow(
            urlString: user.profileImageUrl ?? "",
            userDisplayName: user.displayName ?? user.username ?? "",
            username: user.username ?? "")
            .onTapGesture(perform: onUserAvatarTap)
            .padding(.leading, 15)
            Spacer()
            ZStack{
                Circle()
                  .stroke(
                  isChecked
                      ? Color.wingitBlue
                      : Color.gray,
                    lineWidth: 1
                  )
                  .frame(width: 25, height: 25)
              if isChecked {
                  Image(systemName: "checkmark.circle.fill")
                      .font(.system(size:25))
                    .foregroundColor(.wingitBlue)
                    .padding(.trailing, -1)
              }
            }
        }
        .padding(
          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        )
        .contentShape(Rectangle())
        .onTapGesture(perform: onTapGesture)
      
      }

}

