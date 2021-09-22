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
  var user: User
  
    var body: some View {
        NavigationLink(
          destination: UserProfileView(userId: user.id, user: user)
        ) {
          HStack {
            URLImageView(urlString: user.profileImageUrl)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .overlay(
                  RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            VStack(alignment: .leading, spacing: 5) {
              Text(user.displayName ?? "").font(.headline).bold()
              Text("@\(user.username ?? "")")
              .font(.subheadline)
              .foregroundColor(.wingitBlue)
            }
            .padding(.leading, 10)
            Spacer()
          }
          .padding(10)
        }
        .buttonStyle(PlainButtonStyle())
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
              List {
                ForEach(self.connectionsViewModel.users, id: \.self) { user in
                  ConnectionRow(user: user)
                }
              }
              .navigationBarTitle(formatTitle(), displayMode: .inline)
              .edgesIgnoringSafeArea([.top, .bottom])
            }
        .onAppear {
            connectionsViewModel.loadConnections(userId: user?.id)
           
        }
            .preferredColorScheme(.light)
    }
}
