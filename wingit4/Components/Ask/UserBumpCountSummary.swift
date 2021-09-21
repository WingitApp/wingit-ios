//
//  UserBumpCountSummary.swift
//  wingit4
//
//  Created by Joshua Lee on 9/19/21.
//

import SwiftUI

struct UserBumpCountSummary: View {
    var users: [User]
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
          HStack(alignment: .center) {
            ForEach(Array(users.prefix(limit).enumerated()), id: \.element) { index, user in
              UserAvatar(
                user: user,
                height: size,
                width: size
              )
              .modifier(
                UserAvatarStyle(
                  index: index,
                  color: Color.wingitBlue
                )
              )
              
            }
            BumpersTextDescription.getFormattedCount(
              users: users,
              limit: limit,
              emptyMessage: "You haven't bumped this request to any friends."
            )
            .font(.caption2)
            .frame(height: 17)
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.1)))
            .id(UUID().uuidString)
          }
        }
        .padding(.leading, 15)
        .padding(.bottom, 10)
       
    }
  }
