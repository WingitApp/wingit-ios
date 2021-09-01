//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferButton: View {
<<<<<<< HEAD
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post
=======
    
>>>>>>> 2b84d60 (refer Connections check experiement)
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
            destination: ReferConnectionsList(),
>>>>>>> 2b84d60 (refer Connections check experiement)
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
