//
//  ProfileUserHeader.swift
//  wingit4
//
//  Created by Joshua Lee on 10/2/21.
//

import SwiftUI

struct ProfileUserHeader: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var userProfileViewModel: UserProfileViewModel
  
    var user: User?
    var isOwnProfile: Bool
  
    func onTapOpenConnectionSheet() -> Void {
      self.connectionsViewModel.isConnectionsSheetOpen = true
    }
  
    // todo: add var user
    var body: some View {
      HStack(alignment: .top, spacing: 0){
        VerticalLine()
          .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
          .frame(width: 1, height: 60)
          .padding(.trailing, 15)
          .opacity(0.7)

        VStack(alignment: .leading, spacing: 0) {
          Text(user?.displayName ?? "")
            .font(.title).bold().foregroundColor(Color.black)
            .padding(0)
        
          HStack {
            Text("@" + "\(user?.username ?? "")")
              .bold()
              .font(.subheadline)
              .foregroundColor(Color.wingitBlue)
              .padding(0)
            Circle()
              .frame(width: 4, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color.wingitBlue)
              Text("\(isOwnProfile ? profileViewModel.connections.count : userProfileViewModel.connections.count) Connections")
                .bold()
                .font(.subheadline)
                .foregroundColor(Color.wingitBlue)
                .redacted(reason:
                    (isOwnProfile ? profileViewModel.isFetchingConnections : userProfileViewModel.isFetchingConnections)
                      ? .placeholder
                      : []
                )
                .onTapGesture(perform: onTapOpenConnectionSheet)
          }
          .padding(.top, 5)
        }

      }
      .sheet(
        isPresented: $connectionsViewModel.isConnectionsSheetOpen,
        content: {
          ConnectionsView(
            user: user,
            connections: isOwnProfile ? $profileViewModel.connections : $userProfileViewModel.connections,
            isLoading: isOwnProfile ? $profileViewModel.isFetchingConnections : $userProfileViewModel.isFetchingConnections
          ).environmentObject(connectionsViewModel)
        }
      )
    }
}
