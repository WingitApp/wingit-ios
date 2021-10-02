//
//  ProfileDetail2.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 9/16/21.
//

import SwiftUI

struct ProfileDetail2: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @StateObject var connectionsViewModel = ConnectionsViewModel()

    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
      if maxHeight + yOffset < minHeight {
        return minHeight
      }
      
      return maxHeight + yOffset
    }
    
    func openUpdatePicSheet() {
      self.profileViewModel.isUpdatePicSheetOpen.toggle()
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
          VStack {
            VStack {
              GeometryReader { geometry in
                URLImageView(urlString: session.currentUser?.profileImageUrl)
                    .frame(
                      height: self.calculateHeight(
                        minHeight:0,
                        maxHeight: 230,
                        yOffset: geometry.frame(in: .global).origin.y
                      )
                    )
                    .ignoresSafeArea()
                    .clipped()
                    .offset(
                      y: geometry.frame(in: .global).origin.y < 0
                        ? abs(geometry.frame(in: .global).origin.y)
                        : -geometry.frame(in: .global).origin.y
                    )
              }
            }
            .frame(minHeight: (UIScreen.main.bounds.height / 3.5))
            .onTapGesture(perform: self.openUpdatePicSheet)
            VStack(alignment: .leading) {
              HStack(alignment: .bottom) {
                HStack {
                  URLImageView(urlString: session.currentUser?.profileImageUrl)
                    .frame(width: 120, height: 120)
                    .cornerRadius(100)
                    .padding(5)
                }
                .background(Color.white)
                .cornerRadius(100)
                .onTapGesture(perform: self.openUpdatePicSheet)
                .zIndex(2)
                Spacer()
                ProfileButton()
                .offset(y: -20)
                  
              }
              .offset(y: -64)
              .padding(.bottom, -70)
              .padding(.leading, 15)
              .padding(.trailing, 15)
              .frame(
                width: UIScreen.main.bounds.width
              )
              
            ProfileUserHeader()
              .padding(.leading, 15)
            ProfileDetailView()
            }
            .frame( width: UIScreen.main.bounds.width)
            .background(
              Color.white
              .cornerRadius(30, corners: .topLeft)
              .cornerRadius(30, corners: .topRight)
            )
            .offset(y: -30)
            .padding(.top, -30)
            
      
          }


        }
        .environmentObject(connectionsViewModel)
        .sheet(
          isPresented: $connectionsViewModel.isConnectionsSheetOpen,
          content: {
            ConnectionsView(
              user: session.currentUser!,
              connections: $profileViewModel.connections,
              isLoading: $profileViewModel.isFetchingConnections
            ).environmentObject(connectionsViewModel)
          }
        )
        .sheet(
            isPresented:  $profileViewModel.isUpdatePicSheetOpen,
            content: { UpdateProfilePhoto(user: session.currentUser) }
          )
      .modifier(Popup(
        isPresented: profileViewModel.isEditSheetOpen,
        alignment: .center,
        direction: .bottom,
        content: { EditProfileView().environmentObject(profileViewModel)}))
    }
}
