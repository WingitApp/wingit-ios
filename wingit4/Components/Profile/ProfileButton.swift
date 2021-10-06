//
//  ProfileButton.swift
//  wingit4
//
//  Created by Joshua Lee on 10/1/21.
//

import SwiftUI
import SPAlert

struct ProfileButton: View {
  @EnvironmentObject var profileViewModel: ProfileViewModel
  @EnvironmentObject var userProfileViewModel: UserProfileViewModel
  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel

  var user: User?
  var isOwnProfile: Bool
  
  func getIconName() -> String {
    switch isOwnProfile {
      case true:
        return "square.and.pencil"
      case false:
        if !userProfileViewModel.isConnected && !userProfileViewModel.sentPendingRequest {
          return "plus"
        } else if userProfileViewModel.isConnected {
          return "checkmark"
        } else if !userProfileViewModel.isConnected && userProfileViewModel.receivedPendingRequest {
          return "hand.wave.fill"
        } else if !userProfileViewModel.isConnected && userProfileViewModel.sentPendingRequest {
          return "hand.wave.fill"
        } else {
          return "checkmark"
        }
    }
  }
  
  func getButtonLabel() -> String {
    switch isOwnProfile {
      case true:
        return "Edit Profile"
      case false:
      if userProfileViewModel.isConnected {
        return "Connected"
      } else if userProfileViewModel.receivedPendingRequest {
        return "Accept Request"
      } else if userProfileViewModel.sentPendingRequest {
        return "Pending"
      } else {
        return "Add Connection"
      }
    }
  }
  
  func onButtonTap() -> Void {
    switch isOwnProfile {
      case true:
        profileViewModel.isEditSheetOpen.toggle()
      case false:
        if !userProfileViewModel.isConnected && userProfileViewModel.receivedPendingRequest {
          logToAmplitude(event: .acceptConnectRequest, properties: [.userId: user?.id])

          connectionsViewModel.acceptConnectRequest(userId: user?.id) {
            self.userProfileViewModel.isConnected = true
            self.userProfileViewModel.sentPendingRequest = false
            self.userProfileViewModel.receivedPendingRequest = false
            
            let alertView = SPAlertView(
              title: "",
              message: "Connection request accepted!",
              preset: SPAlertIconPreset.done
            )
              alertView.present(duration: 2)
          }
        } else if !userProfileViewModel.isConnected && !userProfileViewModel.sentPendingRequest {
            logToAmplitude(event: .sendConnectRequest, properties: [.userId: user?.id])
            connectionsViewModel.sendConnectRequest(userId: user?.id) {
              userProfileViewModel.sentPendingRequest = true
              let alertView = SPAlertView(
                title: "",
                message: "Connection request sent!",
                preset: SPAlertIconPreset.done
              )
                alertView.present(duration: 2)
            }
        } else if userProfileViewModel.isConnected {
            logToAmplitude(event: .disconnectFromUser, properties: [.userId: user?.id])
            connectionsViewModel.disconnect(userId: user?.id, connectionsCount_onSuccess: { (connectionsCount) in
              self.userProfileViewModel.isConnected = false
              let alertView = SPAlertView(
                title: "",
                message: "Successfully Disconnected",
                preset: SPAlertIconPreset.done
              )
              alertView.present(duration: 2)
         })
        } else {
          let alertView = SPAlertView(
            title: "",
            message: "Connection request already sent.",
            preset: SPAlertIconPreset.error
          )
            alertView.present(duration: 2)
        }
    }
  }
  
    var body: some View {
        HStack(spacing: 10){
          Text(Image(systemName: getIconName()))
            .font(.system(size: 15))
            .foregroundColor((!isOwnProfile && userProfileViewModel.isConnected) ? Color.green : Color.black)
          
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
        .onTapGesture(perform: onButtonTap)
        .redacted(reason: userProfileViewModel.isFetchingConnectedStatus ? .placeholder : [])
    }
}
