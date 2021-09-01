//
//  Connections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI

struct Connections: View {
    
    var user: User?
    @Binding var connectionsCount: Int
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    
    var body: some View {
        HStack{
            NavigationLink(
                destination: ConnectionsView(user: user!).environmentObject(connectionsViewModel),
                label: {
                    HStack {
                        Text("\(connectionsCount)").font(.caption).foregroundColor(.gray)
                        Text("Connections").font(.caption2).foregroundColor(.gray)
                    }.padding(.top, 5).padding(.leading, 15)
                })
            }
    }
}


