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

    var body: some View {
        Button(action: {
            referViewModel.isReferListOpen.toggle()
        }
            ,
        NavigationLink(
            destination: ReferConnectionsList(post: $post),
            label: {
                Image(systemName: "person.3")
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            })
    }
}
