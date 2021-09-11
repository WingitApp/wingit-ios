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
            ProfileHeader(
              user: self.session.currentUser,
              postCount: profileViewModel.posts.count
//              doneCount: profileViewModel.doneposts.count
            )
        }
        .background(Color(.white))
        .clipShape(RoundedShape(corners: [.bottomLeft,.bottomRight]))
    }
}




