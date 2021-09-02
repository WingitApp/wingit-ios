//
//  AskDetailBody.swift
//  wingit4
//
//  Created by Joshua Lee on 9/1/21.
//

import SwiftUI

struct AskDetailBody: View {
  @Binding var post: Post

    var body: some View {
      VStack(alignment: .leading) {
        Text(post.caption)
//          .modifier(BodyStyle())
          .font(.callout)
//            Text("Description")
//              .font(.headline)
//              .padding(.bottom, 5)
      }
      .padding(
        EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      )
    }
}
