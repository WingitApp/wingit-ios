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
   
    var body: some View {
        VStack {
            List {
                ForEach(self.connectionsViewModel.users, id: \.uid) { user in
                        NavigationLink(destination: UserProfileView(user: user)) {
                            HStack {
                                URLImageView(inputURL: user.profileImageUrl)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                 Text(user.displayName ?? "").font(.headline).bold()
                                    Text(user.bio ?? "").font(.subheadline)
                                }
                            }.padding(10)
                   }
                }
            }
        }
        .navigationBarTitle(Text("Connections"), displayMode: .inline)
        .onAppear {
            connectionsViewModel.loadConnections(userId: user?.id)
        }
    }
}
