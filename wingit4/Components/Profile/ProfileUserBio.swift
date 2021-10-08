//
//  ProfileUserBio.swift
//  wingit4
//
//  Created by Joshua Lee on 10/4/21.
//

import SwiftUI

struct ProfileUserBio: View {
  @EnvironmentObject var profileViewModel: SessionStore // moved user metadata to sessionStore

  var user: User?
  var isOwnProfile: Bool
  var showEmptyState: Bool
  
  init(user: User?, isOwnProfile: Bool) {
    if user != nil && user?.bio == nil {
      self.showEmptyState = true
    } else {
      self.showEmptyState = false
    }
    
    self.user = user
    self.isOwnProfile = isOwnProfile
  }
  
    var body: some View {
      VStack(alignment: .center, spacing: 0){
        if showEmptyState {
          if isOwnProfile {
            Text("Add a description to let others know what you're about.")
              .italic()
              .fontWeight(.regular)
              .font(Font.footnote)
              .foregroundColor(Color.black.opacity(0.7))
              .fixedSize(horizontal: false, vertical: true)
              .onTapGesture {
                profileViewModel.isEditSheetOpen.toggle()
              }
          } else {
            EmptyView()
          }
        } else {
          Text(user?.bio ?? "")
            .fontWeight(.regular)
            .font(Font.footnote)
            .foregroundColor(Color.black.opacity(0.7))
            .fixedSize(horizontal: false, vertical: true)
            .onTapGesture {
              if isOwnProfile {
                profileViewModel.isEditSheetOpen.toggle()
              }
            }
        }
      }
      .padding(.top, 5)
    }
}

