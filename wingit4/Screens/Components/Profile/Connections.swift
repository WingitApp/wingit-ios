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
            HStack {
                Text("\(connectionsCount)")
                Text("Connections")
            }
            .font(.headline)
            .foregroundColor(Color(.systemTeal))
            .padding(.top, 5)
            .onTapGesture {
              self.connectionsViewModel.isConnectionsSheetOpen.toggle()
            }
        }
    }
}


