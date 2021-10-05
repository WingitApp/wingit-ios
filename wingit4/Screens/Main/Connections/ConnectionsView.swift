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
          destination: ProfileView(userId: user.id, user: user)
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
          .padding(
            EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
          )
          Divider()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ConnectionsView: View {
  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
  
  var user: User
  var isOwnProfile: Bool
  @Binding var connections: [User]
  @Binding var isLoading: Bool
  
  init(user: User?, connections: Binding<[User]>, isLoading: Binding<Bool>) {
    self.user = user!
    self.isOwnProfile = Auth.auth().currentUser?.uid == user?.id
    self._connections = connections
    self._isLoading = isLoading
  }
   
  func formatTitle() -> String {
    var title = "Connection";
    
    if isOwnProfile {
      title = "My " + title
    } else {
      title = (user.firstName)! + "'s " + title
    }
    
    if connections.count != 1 {
      title += "s"
    }
    
    return title
  }
  
    var body: some View {
            NavigationView {
              ScrollView {
                VStack(alignment: .leading) {
                  if self.isOwnProfile, connections.isEmpty, !isLoading {
                        NavigationLink(destination: UsersView()) {
                            ConnectionsEmptyState(
                              title: "No Connections!",
                              description: "Tap here to connect with other users.",
                              iconName: "person.badge.plus",
                              iconColor: Color("Color1"),
                              function: nil
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
          
                      ForEach(self.connections, id: \.self) { user in
                        ConnectionRow(user: user)
                        Divider()
                      }
                    }
                }
                .padding(.top, 5)
              }
              .navigationBarTitle(formatTitle(), displayMode: .inline)
                  
            }
            .preferredColorScheme(.light)
    }
}
