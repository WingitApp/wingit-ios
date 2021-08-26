//
//  Connections.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/18/21.
//

import SwiftUI

struct Connections: View {
    
    var user: User?
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    
    var body: some View {
        HStack{
            NavigationLink(
                destination: FollowerView(user: user!),
                label: {
                    HStack {
                        Text("\(followersCount)").font(.caption).foregroundColor(.gray)
                        Text("Followers").font(.caption2).foregroundColor(.gray)
                    }.padding(.top, 5).padding(.trailing, 15)
                })
            NavigationLink(
                destination: FollowingView(user: user!),
                label: {
                    HStack {
                        Text("\(followingCount)").font(.caption).foregroundColor(.gray)
                        Text("Following").font(.caption2).foregroundColor(.gray)
                    }.padding(.top, 5).padding(.leading, 15)
                })
            }
    }
}


