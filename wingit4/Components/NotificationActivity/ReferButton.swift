//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferButton: View {
<<<<<<< HEAD
<<<<<<< HEAD
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post
=======
    
>>>>>>> 2b84d60 (refer Connections check experiement)
=======
    @Binding var post: Post
>>>>>>> 77ddfdf (Referrals Api)
  //  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
//    @EnvironmentObject var session: SessionStore

    var body: some View {
<<<<<<< HEAD
        Button(action: {
            referViewModel.isReferListOpen.toggle()
        }
//                ReferConnectionsList(post: $post)
//                .environmentObject(referViewModel)
            ,
=======
        NavigationLink(
<<<<<<< HEAD
            destination: ReferConnectionsList(),
>>>>>>> 2b84d60 (refer Connections check experiement)
=======
            destination: ReferConnectionsList(post: $post),
>>>>>>> 77ddfdf (Referrals Api)
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

<<<<<<< HEAD

=======
>>>>>>> 2b84d60 (refer Connections check experiement)
