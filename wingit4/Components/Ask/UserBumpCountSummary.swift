//
//  UserBumpCountSummary.swift
//  wingit4
//
//  Created by Joshua Lee on 9/19/21.
//

import SwiftUI

struct UserBumpCountSummary: View {
    @Binding var users: [User]
    var limit: Int = 3
    var size: CGFloat = 25

    func formatDescription() -> Text? {
      let remainder = users.count - limit
      return remainder > 0
        ? Text("+ \(remainder)")
          .fontWeight(.semibold)
          .font(.caption)
        : nil
      
    }
    
      var body: some View {
        VStack(alignment: .leading) {
          Text("Bumped Connections")
            .font(.headline)
            .padding(.top, 10)
            .padding(.bottom, 10)
          HStack {
            ForEach(Array(users.prefix(limit).enumerated()), id: \.element) { index, user in
              UserAvatar(
                user: user,
                height: size,
                width: size
              )
              .modifier(UserAvatarStyle(index: index))
              
            }
            BumpersTextDescription.getFormattedCount(
              users: users,
              limit: limit,
              emptyMessage: "Bump this request to your first friend!"
            )
            .font(.caption2)
        }
        }
        .padding(.leading, 15)
        .padding(.bottom, 10)
       
    }
  }
