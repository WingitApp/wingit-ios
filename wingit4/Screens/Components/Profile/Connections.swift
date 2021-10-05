//
//  Connections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI

struct Connections: View {
    
    var user: User?
    var connectionsCount: Int
    @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    
    var body: some View {
          HStack(alignment: .center, spacing: 5){
                Text("\(connectionsCount)")
                Text("Connections")
            }
            .font(.headline)
            .foregroundColor(.wingitBlue)
            .padding(.top, 2)
            .onTapGesture {
              Haptic.impact(type: "soft")
              self.connectionsViewModel.isConnectionsSheetOpen.toggle()
            }
    }
}


