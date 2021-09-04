//
//  ReferButton.swift
//  wingit4
//
//  Created by YaeRim Amy Chun on 8/31/21.
//

import SwiftUI

struct ReferButton: View {
    @EnvironmentObject var referViewModel: ReferViewModel
    @Binding var post: Post
  //  @EnvironmentObject var connectionsViewModel: ConnectionsViewModel
//    @EnvironmentObject var session: SessionStore

    var body: some View {
        Button(action: {
            referViewModel.isReferListOpen.toggle()
        }
//                ReferConnectionsList(post: $post)
//                .environmentObject(referViewModel)
            ,
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


