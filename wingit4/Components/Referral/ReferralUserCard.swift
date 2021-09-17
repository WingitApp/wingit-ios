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
      //  print("onTap called")
//      if self.referViewModel.allReferralRecipientIds.contains(user.id) {
//            return
//        }
//
//      self.referViewModel.handleUserSelect(userId: user.id)
    }
    
    var body: some View {
        
        HStack{
            UserAvatar(
              user: user,
              height: 40,
              width: 40
            )
          
            VStack(alignment: .leading, spacing: 5) {
                Text(user.displayName ?? user.username ?? "").font(.headline).bold()
                Text("@\(user.username ?? "")").font(.subheadline)
                    .foregroundColor(Color(.systemTeal))
            }
            .padding(.leading, 5)
            Spacer()
            ZStack{
                Circle()
                  .stroke(
                    isChecked || self.referViewModel.selectedUsers.contains(user.id)
                      ? Color(.systemTeal)
                      : Color.gray,
                    lineWidth: 1
                  )
                  .frame(width: 25, height: 25)
              if isChecked || self.referViewModel.selectedUsers.contains(user.id) {
                  Image(systemName: "checkmark.circle.fill")
                      .font(.system(size:25))
                    .foregroundColor(Color(.systemTeal))
              }
            }
        }
        .padding(
          EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        )
        .contentShape(Rectangle())
        .opacity(self.referViewModel.selectedUsers.contains(user.id) ? 0.3 : 1)
        .onTapGesture(perform: onTapGesture)
      }

}

