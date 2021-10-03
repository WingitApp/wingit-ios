//
//  ProfileButton.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI

struct ProfileButton: View {
  @EnvironmentObject var profileViewModel: ProfileViewModel
  
  var isOwnProfile: Bool = true
  var isConnected: Bool = false
  
  func getIconName() -> String {
    switch isOwnProfile {
      case true:
        return "square.and.pencil"
      case false:
        return isConnected ? "checkmark" : "plus"
    }
  }
  
  func getButtonLabel() -> String {
    switch isOwnProfile {
      case true:
        return "Edit Profile"
      case false:
        return isConnected ? "Connected" : "Add Connection"
    }
  }
  
  func onButtonTap() -> Void {
    profileViewModel.isEditSheetOpen.toggle()
  }
  
    var body: some View {
      Button(action: onButtonTap) {
        HStack(spacing: 10){
          Text(Image(systemName: getIconName()))
            .font(.system(size: 15))
            .foregroundColor(Color.black)
          Text(getButtonLabel())
            .fontWeight(.semibold)
            .font(.subheadline)
            .foregroundColor(Color.black)
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .foregroundColor(Color.wingitBlue)
        .clipShape(Capsule())
        .overlay(
          Capsule()
            .stroke(Color.borderGray)
        )
      }
      
    }
}
