//
//  ProfileCard.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/27/21.
//

import SwiftUI

struct ProfileCard: View {
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack{
            ProfileInformation(user: self.session.currentUser)
            Connections(
              user: self.session.currentUser,
              connectionsCount: $profileViewModel.connectionsCountState
            )
            PersonalProfileHeader(
              user: self.session.currentUser
            )
        }
        .background(Color(.white))
        .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
    }
}




