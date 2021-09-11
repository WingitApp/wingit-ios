//
//  ConnectionsView.swift
//  wingit4
//
//  Created by Daniel Yee on 8/10/21.
//

import SwiftUI
import Firebase
import URLImage

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
      VStack(alignment: .leading) {
        HStack {
          Text(self.formatTitle())
            .font(.title2)
            .bold()
          Text("\(connectionsViewModel.connectionsCount)")
            .font(.title2)
            .bold()
            .foregroundColor(Color(.systemTeal))
            .redacted(reason: connectionsViewModel.isLoading ? .placeholder : [])
          Spacer()
          Image(systemName: "xmark")
            .foregroundColor(.gray)
            .onTapGesture {
              self.connectionsViewModel.isConnectionsSheetOpen.toggle()
            }
        }
        .padding(
          EdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        )
            List {
                ForEach(self.connectionsViewModel.users, id: \.uid) { user in
                        NavigationLink(destination: UserProfileView(user: user)) {
                            HStack {
                                URLImageView(inputURL: user.profileImageUrl)
                                    .clipShape(Circle())
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                      RoundedRectangle(cornerRadius: 100)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                  .padding(.leading, -10)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                 Text(user.displayName ?? "").font(.headline).bold()
                                Text(user.username ?? "")
                                  .font(.subheadline)
                                  .italic()
                                  .foregroundColor(Color(.systemTeal))
                                }.padding(.leading, 10)
                            }.padding(10)
                        }
                        .buttonStyle(FlatLinkStyle())
                }
            }
        }
        .navigationBarTitle(Text("Connections"), displayMode: .inline)
        .onAppear {
            connectionsViewModel.loadConnections(userId: user?.id)
        }
    }
}
