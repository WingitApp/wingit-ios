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
      
      if  !referViewModel.userBumps.filter { $0.id == user.id }.isEmpty {
        // we don't need to add users who are already bumped
        return
      }
      self.referViewModel.handleUserSelect(user: user)
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
                  .foregroundColor(.wingitBlue)
            }
            .padding(.leading, 5)
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

