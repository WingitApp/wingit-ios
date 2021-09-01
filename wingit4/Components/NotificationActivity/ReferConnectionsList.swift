//
//  ReferConnections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI
import Firebase
import URLImage

struct ReferConnectionsList: View {
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    var user: User
   
    var body: some View {
        VStack {
            List {
                ForEach(self.connectionsViewModel.users, id: \.uid) { user in
                   Button(action: {}) {
                            HStack {
                            URLImage(URL(string: user.profileImageUrl)!,
                            content: {
                                $0.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                            }).frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                 Text(user.username).font(.headline).bold()
                                    Text(user.bio).font(.subheadline)
                                }
                            }.padding(10)
                   }
                }
            }
        }
        .navigationBarTitle(Text("Connections"), displayMode: .inline)
        .onAppear {
            connectionsViewModel.loadConnections(userId: user.id)
        }
    }
}
