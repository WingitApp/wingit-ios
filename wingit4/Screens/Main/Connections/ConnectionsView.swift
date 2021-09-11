//
//  ConnectionsView.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//

import SwiftUI
import Firebase
import URLImage

struct ConnectionRow: View {
    var user: User
    
    var body: some View {
        NavigationLink(destination: UserProfileView(user: user)) {
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
      }
      .buttonStyle(FlatLinkStyle())
    }
}

struct ConnectionsView: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
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
                List(self.connectionsViewModel.users) { user in
                    ConnectionRow(user: user)
                }
                .navigationBarTitle(formatTitle(), displayMode: .inline)
                .edgesIgnoringSafeArea([.top, .bottom])

            }
//            .navigationBarHidden(true)
        .onAppear {
            connectionsViewModel.loadConnections(userId: user?.id)
        }
    }
}
