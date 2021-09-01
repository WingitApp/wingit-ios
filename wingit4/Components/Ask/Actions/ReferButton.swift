//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferButton: View {
    
  //  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
    @EnvironmentObject var session: SessionStore

    var body: some View {
        NavigationLink(
            destination: ReferConnectionsList(user: self.session.currentUser!),
            label: {
                Image(systemName: "person.3")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            })
//        Button(
//          action: onTapReferIcon,
//          label: {
//            Image(systemName: "person.3")
//        })
//        .foregroundColor(.gray)
//        .padding(.trailing, 10)
    }
}

