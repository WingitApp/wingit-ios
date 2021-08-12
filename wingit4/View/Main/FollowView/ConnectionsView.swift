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
    @ObservedObject var connectionsViewModel = ConnectionsViewModel()
    var user: User
   
    var body: some View {
        VStack {
            List {
                if !connectionsViewModel.isLoading {
                    
                    ForEach(self.connectionsViewModel.users, id: \.uid) { user in
                            NavigationLink(destination: UserProfileView(user: user)) {
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
        }.navigationBarTitle(Text("Connections"), displayMode: .inline)
    }
}
