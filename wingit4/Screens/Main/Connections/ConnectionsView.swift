//
//  ConnectionsView.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ConnectionRow: View {
  
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @ObservedObject var userProfileViewModel: UserProfileViewModel
    
    var user: User
    var userId: String
    
    func onTapGesture() {
        if self.connectionsViewModel.allConnectRecipientIds.contains(userId) {
            return
        }
        self.connectionsViewModel.handleUserSelect(userId: userId)
    }
    
    var body: some View {
    
      NavigationLink(destination: UserProfileView(userId: nil, user: user)) {
          HStack {
              URLImageView(urlString: user.profileImageUrl)
                  .clipShape(Circle())
                  .frame(width: 40, height: 40)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                      .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                  )
                .padding(.leading, -10)
              
              VStack(alignment: .leading, spacing: 5) {
                Text(user.displayName ?? "").font(.headline).bold()
                Text("@\(user.username ?? "")")
                .font(.subheadline)
                .foregroundColor(Color(.systemTeal))
              }.padding(.leading, 10)
          }.padding(10)
      .buttonStyle(FlatLinkStyle())
      }
    }
}

struct ConnectionsView: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
  //  @EnvironmentObject var userProfileViewModel: UserProfileViewModel
    @ObservedObject var userProfileViewModel = UserProfileViewModel()
    
    var user: User?
   
  func formatTitle() -> String {
    var title = "Connection";
    
    if Auth.auth().currentUser?.uid == user?.id {
      title = "My " + title
    } else {
      title = (user?.firstName)! + "'s " + title
    }
    
    if connectionsViewModel.users.count != 1 {
      title += "s"
    }
    
    return title
  }
    
    var body: some View {
            NavigationView {
                if connectionsViewModel.users.count == 0 {
                    EmptyState(
                      title: "No connections!",
                      description: "Help each other out.",
                      iconName: "person.badge.plus",
                      iconColor: Color("Color1"),
                      function: nil
                    )
                } else {
                List(self.connectionsViewModel.users) { user in
                    HStack{
                        ConnectionRow(userProfileViewModel: userProfileViewModel, user: user, userId: user.id ?? "")
                       
                    }
                }
                .navigationBarTitle(formatTitle(), displayMode: .inline)
                .edgesIgnoringSafeArea([.top, .bottom])
                }
            }
//            .navigationBarHidden(true)
        .onAppear {
            connectionsViewModel.loadConnections(userId: user?.id)
           
        }
            .preferredColorScheme(.light)
    }
}
